resource "terraform_data" "k3d_cluster" {
  input = var.environment
  
  provisioner "local-exec" {
    command = <<-EOT
      k3d cluster create ${var.environment} \
        --network ${var.environment}-k3s \
        --servers ${var.k3s_servers} \
        --agents ${var.k3s_agents} \
        --no-lb
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = "k3d cluster delete ${self.input} || true"
  }

  depends_on = [docker_network.k3s]
}