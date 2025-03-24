# Create a VPC network
resource "google_compute_network" "vpc" {
  name                            = var.cluster_name
  routing_mode                    = var.routing_mode
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true

  depends_on = [google_project_service.required_apis]
}


# Create a default route for the VPC network
# We need this route for the NAT gateway.
resource "google_compute_route" "default_route" {
  name             = "control-route"
  description      = "Route for private endpoints to communicate to internet"
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.vpc.self_link
  next_hop_gateway = "default-internet-gateway"
}