terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "kubernetes" {
  #config_path = "clustyconfig"
  host = "${values.host}"
  token = "${values.token}"
  cluster_ca_certificate = "${values.cluster_ca_certificate}"
}
