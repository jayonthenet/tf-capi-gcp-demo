variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "host" {
  description = "The hostname (in form of URI) of Kubernetes master."
  type        = string
}

variable "token" {
  description = "Bearer token for authentication to the API server."
  type        = string
  sensitive   = true
}

variable "cluster_ca_certificate" {
  description = "PEM-encoded root certificates bundle for TLS authentication."
  type        = string
  sensitive   = true
}
