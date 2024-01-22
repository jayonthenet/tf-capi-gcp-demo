terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "= 2.0.2"
    }
  }
}

provider "kubernetes" {
  #config_path = "clustyconfig"
  host                   = var.host
  token                  = base64decode(var.token)
  cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
}
