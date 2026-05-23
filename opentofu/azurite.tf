resource "docker_image" "azurite" {
  name         = "mcr.microsoft.com/azure-storage/azurite:latest"
  keep_locally = true
}

resource "docker_container" "azurite" {
  name  = "forge-azurite"
  image = docker_image.azurite.image_id

  networks_advanced {
    name = docker_network.k3s.name
  }

  ports {
    # Blob
    internal = 10000
    external = 10000
  }
  ports {
    # Queue
    internal = 10001
    external = 10001
  }
  ports {
    # Table
    internal = 10002
    external = 10002
  }
  command = ["azurite", "--blobHost", "0.0.0.0", "--queueHost", "0.0.0.0", "--tableHost", "0.0.0.0", "--skipApiVersionCheck"]
}