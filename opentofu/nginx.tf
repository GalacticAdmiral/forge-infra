resource "docker_image" "nginx" {
  name         = "nginx:alpine"
  keep_locally = true
}

resource "docker_network" "k3s" {
  name = "forge-k3s"
}

resource "docker_container" "nginx" {
  name  = "forge-nginx"
  image = docker_image.nginx.image_id

  networks_advanced {
    name = docker_network.k3s.name
  }

  ports {
    internal = 443
    external = 8443
  }
  ports {
    internal = 80
    external = 8080
  }

  upload {
    content = tls_locally_signed_cert.nginx.cert_pem
    file    = "/etc/nginx/ssl/nginx.crt"
  }
  upload {
    content = tls_private_key.nginx.private_key_pem
    file    = "/etc/nginx/ssl/nginx.key"
  }
  upload {
    content = file("${path.module}/templates/nginx.conf")
    file    = "/etc/nginx/nginx.conf"
  }
}