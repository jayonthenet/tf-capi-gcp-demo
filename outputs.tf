output "kubeconfig" {
    value = data.kubernetes_secret.example.data["value"]
    sensitive = true
}

output "cluster_data" {
    value = yamldecode(data.kubernetes_secret.example.data["value"]).clusters[0].cluster
    sensitive = true
}

output "cluster_type" {
    value = "k8s"
}

output "credentials" {
    value = yamldecode(data.kubernetes_secret.example.data["value"]).users[0].user
    sensitive = true
}

output "load_balancer" {
    value = "192.168.0.1"
}