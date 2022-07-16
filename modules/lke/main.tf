terraform {
  required_providers {
    linode = {
        source = "linode/linode"
        version = "1.28.0"
    }
  }
}

provider "linode" {
  token = var.linode_api_key
}

resource "linode_lke_cluster" "k8-test" {
    label = var.cluster_label
    k8s_version = "1.23"
    region = var.region
    tags = ["k8s-test"]

    pool {
        type = var.pool_type
        count = var.node_count
    }
}

resource "linode_nodebalancer" "k8-test-nodebalancer" {
    label = var.nodebalancer_label
    region = var.region
    tags = ["k8s-test"]
}

variable cluster_label {
    type        = string
    default     = "LKE"
    description = "Linode cluster label"
}

variable region {
    type        = string
    default     = "us-southeast"
    description = "Linode region"
}

variable pool_type {
    type        = string
    default     = "g6-standard-1"
    description = "Linode pool type"
}

variable node_count {
    type        = number
    default     = 3
    description = "Linode node count"
}

variable linode_api_key {
  type        = string
  description = "description"
  sensitive = true
}

variable nodebalancer_label {
    type        = string
    default     = "K8s-Test-Nodebalancer"
    description = "Linode nodebalancer label"
}