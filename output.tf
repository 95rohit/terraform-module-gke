output "kubernetes_cluster_name" {
  description = "The name of the Kubernetes cluster"
  value       = module.gke.name
}

output "kubernetes_cluster_endpoint" {
  description = "The endpoint of the Kubernetes cluster"
  value       = module.gke.endpoint
}

output "kubernetes_cluster_ca_certificate" {
  description = "The CA certificate of the Kubernetes cluster"
  value       = base64decode(module.gke.ca_certificate)
}

output "kubernetes_cluster_token" {
  description = "The token to authenticate to the Kubernetes cluster"
  sensitive   = true
  value       = data.google_client_config.default.access_token
}