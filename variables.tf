variable "abridge_auto_repair" {
  description = "Enable auto repair for abridge node pool"
  type        = bool
  default     = true
}

variable "abridge_auto_upgrade" {
  description = "Enable auto upgrade for abridge node pool"
  type        = bool
  default     = true
}

variable "abridge_node_count" {
  description = "Initial node count for abridge node pool"
  type        = number
  default     = 1
}

variable "abridge_node_disk_size_gb" {
  description = "Disk size in GB for abridge node pool"
  type        = number
  default     = 10
}

variable "abridge_node_machine_type" {
  description = "Machine type for abridge node pool "
  type        = string
  default     = "e2-micro"
}

variable "abridge_node_max_count" {
  description = "Maximum node count for abridge node pool"
  type        = number
  default     = 3
}

variable "abridge_node_min_count" {
  description = "Minimum node count for abridge node pool"
  type        = number
  default     = 1
}

variable "abridge_node_pool" {
  description = "Name of the abridge node pool"
  type        = string
  default     = "abridge-node-pool"
}

variable "abridge_node_pool_enabled" {
  description = "Enable abridge node pool"
  type        = bool
  default     = false
}

variable "abridge_node_pool_label" {
  description = "Labels for abridge node pool"
  type        = map(any)
  default     = {}
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
}

variable "credentials" {
  description = "Path to the service account key file"
  type        = string
  default     = ""
}

variable "default_node_pool_enabled" {
  description = "Enable default node pool"
  type        = bool
  default     = true
}

variable "enable_vertical_pod_autoscaling" {
  description = "Enable vertical pod autoscaling"
  type        = bool
  default     = false
}

variable "horizontal_pod_autoscaling" {
  description = "Enable horizontal pod autoscaling"
  type        = bool
  default     = false
}

variable "iap_ssh_source_ranges" {
  description = "Source IP ranges for IAP SSH access"
  type        = list(string)
  default     = ["35.235.240.0/20"] # Default set to Google IP to be used via google cloud
}

variable "iap_ssh_target_tags" {
  description = "Target tags for IAP SSH access"
  type        = list(string)
  default     = ["iap-ssh"]
}

variable "internal_target_tags" {
  description = "Target tags for internal traffic"
  type        = list(string)
  default     = ["internal"]
}

variable "kubernetes_version" {
  description = "Kubernetes version. Default to latest"
  type        = string
  default     = "latest"
}


variable "node_pool_sa_rules" {
  description = "Access rules for the node pool service account."
  type        = list(string)
  default = [
    "roles/container.defaultNodeServiceAccount",
    "roles/monitoring.viewer",
    "roles/monitoring.metricWriter",
    "roles/logging.logWriter"
  ]
}

variable "outbound_destination_ranges" {
  description = "Destination IP ranges for outbound traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "outbound_target_tags" {
  description = "Target tags for outbound traffic"
  type        = list(string)
  default     = ["outbound"]
}

variable "pods_secondary_cidr" {
  description = "Secondary CIDR for pods IP in the k8s cluster"
  type        = string
  default     = "172.16.0.0/14"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.32.0/19"
}

variable "project_id" {
  description = "Google Project ID"
  type        = string
}


variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.0.0/19"
}

variable "region" {
  description = "Region to deploy VPC/GKE in"
  type        = string
}

variable "routing_mode" {
  description = "Routing mode for the VPC traffic"
  type        = string
  default     = "REGIONAL"
}

variable "services_secondary_cidr" {
  description = "Secondary CIDR for k8s services"
  type        = string
  default     = "172.20.0.0/18"
}
