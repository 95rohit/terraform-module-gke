

# Create Public Subnet
resource "google_compute_subnetwork" "public_subnet" {
  name                     = "${local.cluster_name}-public-subnet"
  ip_cidr_range            = var.public_subnet_cidr
  region                   = var.region
  network                  = google_compute_network.vpc.id
  private_ip_google_access = false       # Public subnet does not need private Google access.
  stack_type               = "IPV4_ONLY" # IPV4 is enough for minimal viable GCP/GKE
}

# Create Private Subnet with Secondary Ranges for Pods and Services
resource "google_compute_subnetwork" "private_subnet" {
  name                     = "${local.cluster_name}-private-subnet"
  ip_cidr_range            = var.private_subnet_cidr
  region                   = var.region
  network                  = google_compute_network.vpc.id
  private_ip_google_access = true # Private subnet needs private Google access.
  stack_type               = "IPV4_ONLY"

  secondary_ip_range {
    range_name    = "k8s-pods"
    ip_cidr_range = var.pods_secondary_cidr
  }

  secondary_ip_range {
    range_name    = "k8s-service"
    ip_cidr_range = var.services_secondary_cidr
  }
}
