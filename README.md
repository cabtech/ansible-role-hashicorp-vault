----
# ansible-role-hashicorp-vault
Runs a Vault server or client

## Required variables
| Name | Type | Purpose |
| -----| ---- | ------- |
| local_ipv4 | IPv4 | IP address of the host running Vault (No namespace as multi-purpose) |

## Default variables
| Name | Value | Purpose |
| -----| ----- | ------- |
| vault_api_port | 8200 | standard port for Vault |
| vault_active_server | active.vault.service.consul | use Consul DNS to find the active node |
| vault_cluster_port | 8201 | standard port used for clustering |
| vault_etc_dir | `/etc/vault` | where the config lives |
| vault_format | zip | used to form the name of the archive to download |
| vault_lib_dir | `/var/lib/vault` | data area (if not using Consul) |
| vault_log_dir | `/var/log/vault` | log files (if used)|
| vault_protocol | 'http' | |
| vault_role | client | ...or server |
| vault_state | started | state of the service |
| vault_version | 1.2.3 | version to download |

## Optional variables
| Name | Type | Purpose |
| -----| ---- | ------- |
| vault_consul_token | UUID | used if Vault uses Consul as its backend and Consul uses ACLs |

## Role Dependencies
- `ansible-role-hashicorp-common`

## To Do
- HI : Run service using acct=vault
- MED : Use Let's Encrypt certificates
- LOW : Allow choice between Consul or file system backend

****
