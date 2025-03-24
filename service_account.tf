# Create Service Account for master nodes
resource "google_service_account" "master_service_accounts" {
  account_id   = local.master_node_sa
  display_name = "Service Account for ${local.master_node_sa}"
  description  = "Service account for ${local.master_node_sa} operations"
}

# Assign IAM Roles to the master-node Service Account
resource "google_project_iam_member" "master_node_sa_roles" {
  count = length(local.master_node_sa_roles)

  project = var.project_id
  role    = local.master_node_sa_roles[count.index]
  member  = "serviceAccount:${google_service_account.master_service_accounts.email}"
}

# Create Service Account for node-pool
resource "google_service_account" "node_pool_service_accounts" {
  account_id   = local.node_pool_sa
  display_name = "Service Account for ${local.node_pool_sa}"
  description  = "Service account for ${local.node_pool_sa} operations"
}

# Assign IAM Roles to the master-node Service Account
resource "google_project_iam_member" "node_pool_sa_roles" {
  count = length(var.node_pool_sa_rules)

  project = var.project_id
  role    = var.node_pool_sa_rules[count.index]
  member  = "serviceAccount:${google_service_account.node_pool_service_accounts.email}"
}

# Add additional service account if need to segregate service account per nodepool group.