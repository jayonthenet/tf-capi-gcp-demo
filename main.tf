data "kubernetes_secret" "example" {
  metadata {
    name      = "capi-quickstart-kubeconfig"
    namespace = "default"
  }
  depends_on = [ kubernetes_manifest.cluster_capi_quickstart ]
}