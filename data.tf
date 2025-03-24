# Fetch all available zones in the specified region
data "google_compute_zones" "available" {
    region = var.region
}

# Need the client_config for output
data "google_client_config" "default" {}