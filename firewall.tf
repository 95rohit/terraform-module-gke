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
