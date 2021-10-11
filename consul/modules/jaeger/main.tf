# see https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account
resource "kubernetes_service_account" "jaeger" {
  metadata {
    name = "jaeger"
  }

  automount_service_account_token = true
}

# see https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment
resource "kubernetes_deployment" "jaeger" {
  metadata {
    name = "jaeger"

    labels = {
      app                           = "jaeger"
      "app.kubernetes.io/name"      = "jaeger"
      "app.kubernetes.io/component" = "all-in-one"
    }
  }

  spec {
    replicas = 1
  
    selector {
      match_labels = {
        app = "jaeger"
      }
    }

    strategy {
      type = "Recreate"
    }

    template {
      metadata {
        labels = {
          app                           = "jaeger"
          "app.kubernetes.io/name"      = "jaeger"
          "app.kubernetes.io/component" = "all-in-one"
        }

        annotations = {
          "prometheus.io/scrape" = "true"
          "prometheus.io/port"   = "16686"
        }
      }

      spec {
        service_account_name = "jaeger"

        container {
          name  = "jaeger"
          image = "jaegertracing/all-in-one:${var.jaeger_version}"
          args  = ["--collector.zipkin.host-port=:9411"]

          port {
            container_port = 9411
            protocol       = "TCP"
          }

          port {
            container_port = 5775
            protocol       = "UDP"
          }

          port {
            container_port = 6831
            protocol       = "UDP"
          }

          port {
            container_port = 6832
            protocol       = "UDP"
          }

          port {
            container_port = 5778
            protocol       = "TCP"
          }

          port {
            container_port = 16686
            protocol       = "TCP"
          }

          readiness_probe {
            http_get {
              path = "/"
              port = 14269
            }

            initial_delay_seconds = 5
          }
        }
      }
    }
  }
}

# see https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service
resource "kubernetes_service" "jaeger" {
  metadata {
    name = "jaeger"

    labels = {
      app                           = "jaeger"
      "app.kubernetes.io/name"      = "jaeger"
      "app.kubernetes.io/component" = "collector"
    }
  }

  spec {
    selector = {
      "app.kubernetes.io/name"      = "jaeger"
      "app.kubernetes.io/component" = "all-in-one"
    }

    port {
      name        = "jaeger"
      port        = 9411
      target_port = 9411
      protocol    = "TCP"
    }

    port {
      name        = "jaeger-collector-tchannel"
      port        = 14267
      target_port = 14267
      protocol    = "TCP"
    }

    port {
      name        = "jaeger-collector-http"
      port        = 14268
      target_port = 14268
      protocol    = "TCP"
    }

    type = "ClusterIP"
  }
}

# see https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service
resource "kubernetes_service" "jaeger_agent" {
  metadata {
    name = "jaeger-agent"

    labels = {
      app                           = "jaeger"
      "app.kubernetes.io/name"      = "jaeger"
      "app.kubernetes.io/component" = "agent"
    }
  }

  spec {
    selector = {
      "app.kubernetes.io/name"      = "jaeger"
      "app.kubernetes.io/component" = "all-in-one"
    }

    port {
      name        = "agent-zipkin-thrift"
      port        = 5775
      target_port = 5775
      protocol    = "UDP"
    }

    port {
      name        = "agent-compact"
      port        = 6831
      target_port = 6831
      protocol    = "UDP"
    }

    port {
      name        = "agent-binary"
      port        = 6832
      target_port = 6832
      protocol    = "UDP"
    }

    port {
      name        = "agent-configs"
      port        = 5778
      target_port = 5778
      protocol    = "TCP"
    }

    cluster_ip = "None"
  }
}

# see https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service
resource "kubernetes_service" "jaeger_query" {
  metadata {
    name = "jaeger-query"

    labels = {
      app                           = "jaeger"
      "app.kubernetes.io/name"      = "jaeger"
      "app.kubernetes.io/component" = "query"
    }
  }

  spec {
    selector = {
      "app.kubernetes.io/name"      = "jaeger"
      "app.kubernetes.io/component" = "all-in-one"
    }

    port {
      name        = "query-http"
      port        = 80
      target_port = 16686
      protocol    = "TCP"
    }

    type = "LoadBalancer"
  }
}
