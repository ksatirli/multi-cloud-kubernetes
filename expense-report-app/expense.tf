resource "kubernetes_service_account" "expense" {
  metadata {
    name = "expense"
  }

  automount_service_account_token = true
}

resource "kubernetes_deployment" "expense" {
  metadata {
    name = "expense"
    labels = {
      app     = "expense"
      release = "v1"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app     = "expense"
        release = "v1"
      }
    }

    template {
      metadata {
        labels = {
          app     = "expense"
          release = "v1"
        }

        annotations = {
          "vault.hashicorp.com/agent-inject"       = "true"
          "vault.hashicorp.com/agent-init-first"   = "true"
          "vault.hashicorp.com/role"               = vault_kubernetes_auth_backend_role.expense_service.role_name #"expense"
          "vault.hashicorp.com/agent-cache-enable" = "true"
        }
      }

      spec {
        service_account_name = kubernetes_service_account.expense.metadata.0.name
        container {
          image = "nicholasjackson/expenses-report:expense-latest"
          name  = "expense"

          command = ["/bin/sh"]
          args    = ["-c", "/app/expense-report"]

          port {
            container_port = 5001
          }

          env {
            name  = "VAULT_ADDR"
            value = "http://localhost:8200"
          }

          env {
            name  = "LISTEN_ADDR"
            value = "0.0.0.0:5001"
          }

          env {
            name  = "MYSQL_CONNECTION"
            value = "root:password@tcp(expense-db-mysql.default.svc:3306)/DemoExpenses"
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/health"
              port = 5001
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "expense" {
  metadata {
    name = "expense"
  }
  spec {
    selector = {
      app = kubernetes_deployment.expense.metadata.0.labels.app
    }
    port {
      port        = 5001
      target_port = 5001
    }

    type = "LoadBalancer"
  }
}