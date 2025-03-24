# This module will create Public master nodes for the assignment use case.
# In production we might want to use a gke private cluster submodule to
# create private cluster.

module "gke" {
  source                          = "terraform-google-modules/kubernetes-engine/google"
  version                         = "~> 36.0"
  project_id                      = var.project_id
  name                            = var.cluster_name
  region                          = var.region # crerating a regional cluster for HA
  zones                           = [data.google_compute_zones.available.names[0], data.google_compute_zones.available.names[1], data.google_compute_zones.available.names[2]]
  network                         = google_compute_network.vpc.name
  subnetwork                      = google_compute_subnetwork.private_subnet.name
  kubernetes_version              = var.kubernetes_version
  deletion_protection             = false # For production cluster, use default value true 
  ip_range_pods                   = "k8s-pods"
  ip_range_services               = "k8s-service"
  http_load_balancing             = false # Will setup Ingress inside k8s to manage traffic/services
  network_policy                  = true  # Providing option to create NetworkPolicy inside k8s for enhanced security.
  horizontal_pod_autoscaling      = var.horizontal_pod_autoscaling
  enable_vertical_pod_autoscaling = var.enable_vertical_pod_autoscaling
  service_account                 = google_service_account.master_service_accounts.email # Avoid using default service account
  logging_service                 = "none"                                               # Enable if not using external logging.
  monitoring_service              = "none"                                               # Enable if not using external monitoring.
  release_channel                 = "STABLE"                                             # Sets the GKE release channel for stability.


  # Add more node pools below as the requirement grows.
  node_pools = [
    merge(
      var.default_node_pool_enabled == true ? local.default_node_pool : {},
    var.abridge_node_pool_enabled == true ? local.abridge_node_pool : {})
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = var.default_node_pool_enabled == true ? { default-node-pool = true } : {}
    abridge-node-pool = var.abridge_node_pool_enabled == true ? var.abridge_node_pool_label : {}
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = var.default_node_pool_enabled == true ? { node-pool-metadata-custom-value = "my-node-pool" } : {}
    abridge-node-pool = var.abridge_node_pool_enabled == true ? var.abridge_node_pool_label : {}
  }

  node_pools_taints = {
    all = []
  }

  node_pools_tags = {
    all = ["gke-node"]
  }

}
