output "vault_addr" {
  value = kubernetes_service.vault.status.load_balancer.ingress.0.ip
}