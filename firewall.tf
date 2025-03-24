# Below log_config is recommended to use in production
# especially if not using external logging.
#   log_config {
#     metadata = "INCLUDE_ALL_METADATA"
#   }

# Allow SSH access via IAP
resource "google_compute_firewall" "allow_iap_ssh" {
  name    = "allow-iap-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.iap_ssh_source_ranges
  direction     = "INGRESS"
  target_tags   = var.iap_ssh_target_tags
}

# Allow internal traffic within the VPC, including pods and services
resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = concat([var.public_subnet_cidr, var.private_subnet_cidr, var.pods_secondary_cidr, var.services_secondary_cidr])
  direction     = "INGRESS"
  target_tags   = var.internal_target_tags
}

# Deny all other inbound traffic by default
resource "google_compute_firewall" "deny_all_inbound" {
  name    = "deny-all-inbound"
  network = google_compute_network.vpc.name

  deny {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"
  priority      = 1000
}

# Allow outbound traffic to specific destinations and ports
resource "google_compute_firewall" "allow_outbound" {
  name    = "allow-outbound"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["443"] # Allow HTTPS traffic
  }

  destination_ranges = var.outbound_destination_ranges
  direction          = "EGRESS"
  target_tags        = var.outbound_target_tags
}
