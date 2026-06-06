# Forge Infra
> [!NOTE]
> Hi there! This project mirrors the production stack i manage at work.
> I have rebuilt it as a local lab environment for development and learning.
> No proprietary components are included as for example custom tomcat image with .war.  

IaC homelab mirroring a production k3s stack.

> [!NOTE]
> In my own repo i like to keep common commands in the start of the file, also for the devlopers when they need for some reason to run it.  

| Common Commands | |
| --- | --- |
| plan | `tofu plan -var-file=envs/<env>.tfvars` |
| apply | `tofu apply -var-file=envs/<env>.tfvars` |
| destroy | `tofu destroy -var-file=envs/<env>.tfvars` |

## Architecture

### OpenTofu
| Component | Description |
| --- | --- |
| Nginx | A reverse proxy into other infrastructure, main function to direct to a healthy k3s node |
| K3d cluster | In this scenario provisions docker-containers to simulate a production environment | 
| Azurite | Simulate Azure Storage endpoints |

### K3s
| Component | Description |
| --- | --- |
| vendor | Vendored 3rd-party manifests (cert-manager, CloudNativePG). Pinned versions tested before production rollout |
| certificates.yaml | Deploy CA and certs needed in applications like mTLS for RabbitMQ |
| postfix.yaml | Setup of mail service for tomcat application |
| postgresql.yaml | Database configuration with recovery from Azure blob|
| postgresql-bootstrap.yaml | Database configuration for a new setup |
| rabbitmq.yaml | Message queue mainly for tomcat application |
| tomcat.yaml | Tomcat application with custom war that can not be shared |
| valkey.yaml | Caching for tomcat application |

### Ansible
| Component | Description |
| --- | --- |
| bootstrap.yaml | Initial setup to deploy ansible user with SSH with passwordless sudo |
| playbook.yaml | Main playbook |
| roles/common | Standard setup on all servers |
| roles/ubuntu | Remove snapd and prevent reinstall |
| roles/users | Create admins and users from SSH public keys |
| roles/preferences | Optional per-user shell and other dotfile configs |
| roles/qemu_agent | QEMU guest agent for proxmox VMs |
| keys/ | SSH pub keys - admins/ ansible/ users/ not to be published public |