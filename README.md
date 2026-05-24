# Forge Infra
> [!IMPORTANT]
> README.md and the repo itself is under construction.
> Its based on stack im running currently.

IaC homelab mirroring a production k3s stack.

## Architecture

### OpenTofu
| Component | Description |
| --- | --- |
| Nginx | A reverse proxy into other infrastructure, main function to direct to a healty k3s node |
| K3d cluster | In this scenario provisions docker-containers to simulate a production environment | 
| Azurite | Simulate Azure Storage endpoints |

### K3s
| Component | Description |
| --- | --- |
| Vendor | Vendored 3rd-party manifests (cert-manager, CloudNativePG). Pinned versions tested before production rollout |
| certificates.yaml | deploy CA and certs needed in applications like mTLS for RabbitMQ |
| postfix.yaml | setup of mail service for tomcat application |
| postgresql.yaml | Database configuration |
| rabbitmq.yaml | message queue mainly for tomcat application |
| tomcat.yaml | tomcat application with custom war that can not be shared |
| valkey.yaml | caching for tomcat appliaction |