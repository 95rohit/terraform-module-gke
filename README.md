# terraform-module-gke
Terraform code for deploying GKE clusters.

This Terraform module creates a Google Kubernetes Engine (GKE) cluster with various configurable options. It allows you to customize the cluster's settings, including node pools, network configurations, and Kubernetes features.

## Setup

To deploy this module and set up a Kubernetes cluster, follow the instructions below.

### Prerequisites

1. **Install Terraform**:
   - Download and install Terraform from the [official website](https://www.terraform.io/downloads.html).
   - Verify the installation by running `terraform -v` in your terminal.
   - This module is tested using Terraform version v1.11.0, ensure to use `v1.11.0` or above.

2. **Install Google Cloud SDK**:
   - Download and install the Google Cloud SDK from the [official website](https://cloud.google.com/sdk/docs/install).
   - Install the Google auth plugin to connect to the Kubernetes cluster.
   - Initialize the SDK by running `gcloud init` and follow the prompts to authenticate and set up your project.

3. **Set Up Google Cloud Project**:
   - Ensure you have a Google Cloud project set up.
   - Ensure you have billing set up for the project.

4. **Configure Authentication**:
   - Either provide a service account `credentials` with the necessary permissions to create VPC, routes, and GKE. Check module usage to understand how to provide credentials.
   - Or authenticate with Google Cloud using a service account with the necessary permissions:
     ```sh
     gcloud auth application-default login
     ```

5. **Set Up Environment Variables**:
   - Set up the required environment variables in a `.tfvars` file or export them in your terminal session:
     ```sh
     export TF_VAR_project_id="your-project-id"
     export TF_VAR_region="your-region"
     export TF_VAR_cluster_name="your-cluster-name"
     export TF_VAR_key="file('/path/to/key')"
     ```

6. **Initialize and Apply Terraform Configuration**:
   - Initialize the Terraform configuration:
     ```sh
     terraform init
     ```
   - Either apply the Terraform configuration using environment variables:
     ```sh
     terraform apply
     terraform apply -var-file=$var_file.tfvars
     ```
   - Or apply the Terraform configuration using `.tfvars`:
     ```sh
     terraform apply -var-file=$var_file.tfvars
     ```

7. **Connect to the Kubernetes Cluster**:
   - After the apply is successfully completed, run the following command to connect to the Kubernetes cluster:
     ```sh
     gcloud container clusters get-credentials $CLUSTER_NAME --region $CLUSTER_REGION --project $PROJECT_ID
     ```

## Usage

### Module

```hcl
module "gke" {
  source                          = "git@github.com:95rohit/terraform-module-gke?ref=${MODULE_VERSION}"
  project_id                      = var.project_id
  cluster_name                    = var.cluster_name
  region                          = var.region
  private_subnet_cidr             = var.private_subnet_cidr
  public_subnet_cidr              = var.public_subnet_cidr
  pods_secondary_cidr             = var.pods_secondary_cidr
  services_secondary_cidr         = var.services_secondary_cidr
  credentials                     = var.credentials
  abridge_node_pool_enabled       = var.abridge_node_pool_enabled
  abridge_node_count              = var.abridge_node_count
  node_pool_sa_rules              = var.node_pool_sa_rules
}
```
### terraform.tfvars
```hcl

project_id                   = "test-project"
cluster_name                 = "test-gke-cluster"
region                       = "us-central1"
private_subnet_cidr          = "10.0.32.0/19"
public_subnet_cidr           = "10.0.0.0/19"
pods_secondary_cidr          = "172.16.0.0/14"
services_secondary_cidr      = "172.20.0.0/18"
credentials                  = "/path/to/credential.json/file"
abridge_node_pool_enabled    = true
abridge_node_count           = 2

node_pool_sa_rules  = [
  "roles/resourcemanager.projectIamAdmin",
  "roles/iam.serviceAccountUser",
  "roles/compute.viewer",
  "roles/container.developer"
]

```

Make sure to replace the placeholder values with your actual project ID, region, and cluster name.


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name                           | Description                                      | Type          | Default                                    | Required |
|--------------------------------|--------------------------------------------------|---------------|--------------------------------------------|:--------:|
| abridge_auto_repair            | Enable auto repair for abridge node pool         | `bool`        | `true`                                     | no       |
| abridge_auto_upgrade           | Enable auto upgrade for abridge node pool        | `bool`        | `true`                                     | no       |
| abridge_node_count             | Initial node count for abridge node pool         | `number`      | `1`                                        | no       |
| abridge_node_disk_size_gb      | Disk size in GB for abridge node pool            | `number`      | `10`                                       | no       |
| abridge_node_machine_type      | Machine type for abridge node pool               | `string`      | `e2-micro`                                 | no       |
| abridge_node_max_count         | Maximum node count for abridge node pool         | `number`      | `3`                                        | no       |
| abridge_node_min_count         | Minimum node count for abridge node pool         | `number`      | `1`                                        | no       |
| abridge_node_pool              | Name of the abridge node pool                    | `string`      | `abridge-node-pool`                        | no       |
| abridge_node_pool_enabled      | Enable abridge node pool                         | `bool`        | `false`                                    | no       |
| abridge_node_pool_label        | Labels for abridge node pool                     | `map(any)`    | `{}`                                       | no     |
| cluster_name                   | Name of the GKE cluster                          | `string`      | n/a                                        | yes      |
| credentials                    | Path to the service account key file             | `string`      | `/`                                        | no       |
| default_node_pool_enabled      | Enable default node pool                         | `bool`        | `true`                                     | no       |
| enable_vertical_pod_autoscaling| Enable vertical pod autoscaling                  | `bool`        | `false`                                    | no       |
| horizontal_pod_autoscaling     | Enable horizontal pod autoscaling                | `bool`        | `false`                                    | no       |
| iap_ssh_source_ranges          | Source IP ranges for IAP SSH access              | `list(string)`| `["35.235.240.0/20"]`                       | no       |
| iap_ssh_target_tags            | Target tags for IAP SSH access                   | `list(string)`| `["iap-ssh"]`                              | no       |
| internal_target_tags           | Target tags for internal traffic                 | `list(string)`| `["internal"]`                             | no       |
| kubernetes_version             | Kubernetes version. Default to latest            | `string`      | `latest`                                   | no       |
| node_pool_sa_rules             | Access rules for the node pool service account   | `list(string)`| `["roles/container.defaultNodeServiceAccount", "roles/monitoring.viewer", "roles/monitoring.metricWriter", "roles/logging.logWriter"]` | no       |
| outbound_destination_ranges    | Destination IP ranges for outbound traffic       | `list(string)`| `["0.0.0.0/0"]`                            | no       |
| outbound_target_tags           | Target tags for outbound traffic                 | `list(string)`| `["outbound"]`                             | no       |
| pods_secondary_cidr            | Secondary CIDR for pods IP in the k8s cluster    | `string`      | `172.16.0.0/14`                            | no       |
| private_subnet_cidr            | CIDR block for the private subnet                | `string`      | `10.0.32.0/19`                             | no       |
| project_id                     | Google Project ID                                | `string`      | n/a                                        | yes      |
| public_subnet_cidr             | CIDR block for the public subnet                 | `string`      | `10.0.0.0/19`                              | no       |
| region                         | Region to deploy VPC/GKE in                      | `string`      | n/a                                        | yes      |
| routing_mode                   | Routing mode for the VPC traffic                 | `string`      | `REGIONAL`                                 | no       |
| services_secondary_cidr        | Secondary CIDR for k8s services                  | `string`      | `172.20.0.0/18`                            | no       |

## Outputs

| Name                          | Description                                      |
|-------------------------------|--------------------------------------------------|
| kubernetes_cluster_name       | The name of the Kubernetes cluster               |
| kubernetes_cluster_endpoint   | The endpoint of the Kubernetes cluster           |
| kubernetes_cluster_ca_certificate | The CA certificate of the Kubernetes cluster |
| kubernetes_cluster_token      | The token to authenticate to the Kubernetes cluster (sensitive) |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->