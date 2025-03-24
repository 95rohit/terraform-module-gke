# Enable required APIs for the active project
resource "google_project_service" "required_apis" {
  for_each = toset(local.apis)
  project  = var.project_id
  service  = each.key

  disable_on_destroy = false
}
