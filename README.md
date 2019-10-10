----
# ansible-role-hashicorp-vault

## Required variables
| Name | Purpose |
| -----| ------- |
| vault_address | IP addresses of the host running Vault |

## Default variables
| Name | Value | Purpose |
| -----| ----- | ------- |
| vault_etc_dir | `/etc/vault` | where the config lives |
| vault_format |  zip | used to form the name of the archive to download |
| vault_port |  8200 | standard port for Vault |
| vault_state |  started | state of the service |
| vault_var_dir | `/var/vault` | where the log and data directories live |
| vault_version |  1.2.3 | version to download |

## To Do
- Support Consul backend
- Let's Encrypt certificates for HTTPS
- Separate vault system user

****
