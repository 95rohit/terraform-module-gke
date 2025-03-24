# Create a static IP for the NAT gateway.
# Don't need to use PREMIUM for assignment but
# definately for production system.
resource "google_compute_address" "nat_ip" {
  name         = "nat-ip"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"

  depends_on = [google_project_service.required_apis]
}


# Create a Cloud Router for NAT Gateway
resource "google_compute_router" "router" {
  name    = "${local.cluster_name}-router"
  network = google_compute_network.vpc.id
  region  = var.region
}

# Create a NAT Gateway using the Cloud Router
resource "google_compute_router_nat" "nat_gateway" {
  name                               = "${local.cluster_name}-nat"
  router                             = google_compute_router.router.name
  region                             = var.region

  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.nat_ip.self_link]

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.private_subnet.self_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

}
