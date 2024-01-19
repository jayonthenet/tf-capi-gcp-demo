terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
   }
    helm = {
      source = "hashicorp/helm"
    }
    humanitec = {
      source = "humanitec/humanitec"
    }
  }
}

provider "kubernetes" {
  config_path = "kubeconfig"
}