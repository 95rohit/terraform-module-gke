provider "google" {
  project     = var.project_id
  region      = local.region
  credentials = var.credentials != "" ? file(var.credentials) : null
}

terraform {
  required_version = ">= 1.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}
