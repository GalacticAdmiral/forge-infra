variable "environment" {
  description = "Environment name (dev, stg, prod)"
  type        = string
}

variable "domain" {
  description = "Domain for SSL cert"
  type        = string
}

variable "k3s_servers" {
  description = "Number of k3s control-plane nodes"
  type        = number
}

variable "k3s_agents" {
  description = "Number of k3s worker nodes"
  type        = number
}