terraform {
  backend "s3" {
    bucket     = "terraform-state"
    key        = "forge-infra/terraform.tfstate"
    region     = "garage"
    endpoints  = { s3 = "http://nas.mechanicus.local:3900" }

    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true
  }

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

provider "docker" {}