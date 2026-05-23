resource "terraform_data" "k3d_cluster" {
  input = "forge"

  provisioner "local-exec" {
    command = <<-EOT
      k3d cluster create forge \
        --network forge-k3s \
        --servers 3 \
        --agents 2 \
        --no-lb \
        --k3s-arg "--disable=traefik@server:*"
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = "k3d cluster delete forge || true"
  }

  depends_on = [docker_network.k3s]
}