variable "abridge_auto_repair" {
  type    = bool
  default = true
}

variable "abridge_auto_upgrade" {
  type    = bool
  default = true
}

variable "abridge_node_count" {
  type    = number
  default = 1
}

variable "abridge_node_disk_size_gb" {
  type    = number
  default = 10
}

variable "abridge_node_machine_type" {
  type    = string
  default = "e2-micro"
}

variable "abridge_node_max_count" {
  type    = number
  default = 3
}

variable "abridge_node_min_count" {
  type    = number
  default = 1
}

variable "abridge_node_pool" {
  type    = string
  default = "abridge-node-pool"
}

variable "abridge_node_pool_enabled" {
  type    = bool
  default = false
}

variable "abridge_node_pool_label" {
  type    = map(any)
  default = {}
}


variable "cluster_name" {
  type = string
}

variable "default_node_pool_enabled" {
  type    = bool
  default = true
}

variable "enable_vertical_pod_autoscaling" {
  type    = bool
  default = false
}

variable "horizontal_pod_autoscaling" {
  type    = bool
  default = false
}

variable "iap_ssh_source_ranges" {
  description = "Source IP ranges for IAP SSH access"
  type        = list(string)
  default     = ["35.235.240.0/20"]
}

variable "iap_ssh_target_tags" {
  description = "Target tags for IAP SSH access"
  type        = list(string)
  default     = ["iap-ssh"]
}

variable "kubernetes_version" {
  type    = string
  default = "latest"
}


variable "node_pool_sa_rules" {
  description = "Access rules for the node pool service account."
  type        = list(string)
  default     = [
    "roles/container.defaultNodeServiceAccount",
    "roles/monitoring.viewer",
    "roles/monitoring.metricWriter",
    "roles/logging.logWriter"
  ]
}


variable "pods_secondary_cidr" {
  type    = string
  default = "172.16.0.0/14"
}

variable "private_subnet_cidr" {
  type    = string
  default = "10.0.32.0/19"
}

variable "project_id" {
  type    = string
  default = ""
}


variable "public_subnet_cidr" {
  type    = string
  default = "10.0.0.0/19"
}

variable "region" {
  type = string
}

variable "routing_mode" {
  type    = string
  default = "REGIONAL"
}

variable "services_secondary_cidr" {
  type    = string
  default = "172.20.0.0/18"
}