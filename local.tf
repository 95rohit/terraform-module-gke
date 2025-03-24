locals {
  cluster_name = var.cluster_name
  region       = var.region

  apis = [
    "container.googleapis.com",
    "logging.googleapis.com",
    "secretmanager.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",                 # IAM API
    "cloudresourcemanager.googleapis.com" # Resource Manager API
  ]
  master_node_sa = "master-node-sa"
  node_pool_sa   = "node-pool-sa"
  master_node_sa_roles = [
    "roles/container.defaultNodeServiceAccount",
    "roles/monitoring.viewer",
    "roles/monitoring.metricWriter",
    "roles/logging.logWriter"
  ]

  default_node_pool = {
    name                 = "default-node-pool"
    machine_type         = "e2-micro"
    min_count            = 1
    max_count            = 3
    disk_size_gb         = 10
    initial_node_count   = 1
    auto_repair          = true
    auto_upgrade         = true
    service_account      = google_service_account.node_pool_service_accounts.email
    enable_private_nodes = true
  }

  abridge_node_pool = {
    name                 = var.abridge_node_pool
    machine_type         = var.abridge_node_machine_type
    min_count            = var.abridge_node_min_count
    max_count            = var.abridge_node_max_count
    disk_size_gb         = var.abridge_node_disk_size_gb
    initial_node_count   = var.abridge_node_count
    auto_repair          = var.abridge_auto_repair
    auto_upgrade         = var.abridge_auto_upgrade
    service_account      = google_service_account.node_pool_service_accounts.email
    enable_private_nodes = true # For security best practice keep nodes private.
  }

  # Add more node pools config here.
}
