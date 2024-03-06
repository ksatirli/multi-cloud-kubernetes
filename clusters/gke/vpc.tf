locals {
  /*  For more information on configuring IAP TCP forwarding see: 
  https://cloud.google.com/iap/docs/using-tcp-forwarding#create-firewall-rule  */
  iap_tcp_forwarding_cidr_range = "35.235.240.0/20"

  /*  For more information on configuring private Google access see: 
  https://cloud.google.com/vpc/docs/configure-private-google-access#config  */
  private_google_access_cidr_range    = "199.36.153.8/30"
  restricted_google_access_cidr_range = "199.36.153.4/30"

  private_service_access_dns_zones = {
    pkg-dev = {
      dns = "pkg.dev."
      ips = ["199.36.153.4", "199.36.153.5", "199.36.153.6", "199.36.153.7"]
    }
    gcr-io = {
      dns = "gcr.io."
      ips = ["199.36.153.4", "199.36.153.5", "199.36.153.6", "199.36.153.7"]
    }
    googleapis = {
      dns = "googleapis.com."
      ips = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]
    }
  }
}

resource "google_compute_network" "default" {
  name                            = var.tfe_workspaces_prefix
  auto_create_subnetworks         = false
  project                         = var.google_project
  routing_mode                    = "GLOBAL"
  delete_default_routes_on_create = true
}

# Create a subnet for the GKE cluster
resource "google_compute_subnetwork" "default" {
  name                     = var.tfe_workspaces_prefix
  ip_cidr_range            = "10.0.0.0/16"
  region                   = var.google_region
  network                  = google_compute_network.default.id
  private_ip_google_access = true
  project                  = var.google_project

  secondary_ip_range {
    range_name    = "gke-services"
    ip_cidr_range = "10.1.0.0/16"
  }

  secondary_ip_range {
    range_name    = "gke-pods"
    ip_cidr_range = "10.2.0.0/20"
  }

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
  }
}

# A quad-zero route
resource "google_compute_route" "public_internet" {
  network          = google_compute_network.default.id
  name             = "quad-zero"
  description      = "Custom stati cquad-zero route"
  dest_range       = "0.0.0.0/0"
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
  project          = var.google_project
}

# Allow internal traffic within the network
resource "google_compute_firewall" "allow_internal_ingress" {
  name          = "allow-internal-ingress"
  network       = google_compute_network.default.name
  direction     = "INGRESS"
  source_ranges = ["10.128.0.0/9"]
  project       = var.google_project

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
}

# Allow egress traffic to the GKE control plane
resource "google_compute_firewall" "allow_egress_to_gke_control_plane" {
  name               = "allow-egress-to-gke-control-plane"
  network            = google_compute_network.default.name
  project            = var.google_project
  direction          = "EGRESS"
  destination_ranges = ["10.3.0.0/28"]
  priority           = 65534

  allow {
    protocol = "tcp"
  }
}

# Allow incoming TCP traffic from Identity-Aware Proxy (IAP)
resource "google_compute_firewall" "allow_iap_tcp_ingress" {
  name          = "allow-iap-tcp-ingress"
  network       = google_compute_network.default.name
  direction     = "INGRESS"
  project       = var.google_project
  source_ranges = [local.iap_tcp_forwarding_cidr_range]
  priority      = 1000

  allow {
    protocol = "tcp"
  }
}

# Allow private google access egress traffic
resource "google_compute_firewall" "allow_private_google_access_egress" {
  network     = google_compute_network.default.id
  name        = "allow-private-google-access-egress"
  description = "Allow private google access for all instances"
  priority    = 1000
  direction   = "EGRESS"
  target_tags = []
  project     = var.google_project

  destination_ranges = [
    local.private_google_access_cidr_range,
    local.restricted_google_access_cidr_range,
  ]

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}

# Create private DNS zones to route traffic to private google access IPs
resource "google_dns_managed_zone" "private_service_access" {
  for_each   = { for k, v in local.private_service_access_dns_zones : k => v }
  name       = each.key
  dns_name   = each.value.dns
  visibility = "private"
  project    = var.google_project

  private_visibility_config {
    dynamic "networks" {
      for_each = ["${google_compute_network.default.id}"]

      content {
        network_url = google_compute_network.default.id
      }
    }
  }
}

resource "google_dns_record_set" "a_records" {
  for_each = { for k, v in google_dns_managed_zone.private_service_access : k => v }

  name         = each.value.dns_name
  managed_zone = each.value.name
  type         = "A"
  ttl          = 300
  rrdatas      = local.private_service_access_dns_zones[each.key].ips
  project      = var.google_project
}

resource "google_dns_record_set" "cname_records" {
  for_each = { for k, v in google_dns_managed_zone.private_service_access : k => v }

  name         = "*.${each.value.dns_name}"
  managed_zone = each.value.name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = [each.value.dns_name]
  project      = var.google_project
}

# Route private google access traffic to the default internet gateway
resource "google_compute_route" "private_google_access" {
  network          = google_compute_network.default.id
  name             = "private-google-access"
  description      = "Custom static route to communicate with Google APIs using private.googleapis.com"
  dest_range       = local.private_google_access_cidr_range
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
  project          = var.google_project
}

# Route restricted google access traffic to the default internet gateway
resource "google_compute_route" "restricted_google_access" {
  network          = google_compute_network.default.id
  name             = "restricted-google-access"
  description      = "Custom static route to communicate with Google APIs using restricted.googleapis.com"
  dest_range       = local.restricted_google_access_cidr_range
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
  project          = var.google_project
}
