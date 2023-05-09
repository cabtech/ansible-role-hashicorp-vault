----
# ansible-role-hashicorp-vault
Runs a Vault server or client

## Required variables
| Name | Type | Purpose |
| -----| ---- | ------- |
| local_ipv4 | IPv4 | IP address of the host running Vault (No namespace as multi-purpose) |

## Default variables
| Name | Type | Value | Purpose |
| -----| ---- | ----- | ------- |
| vault_api_port | integer | 8200 | standard port for Vault |
| vault_active_server | string | active.vault.service.consul | use Consul DNS to find the active node |
| vault_builds | list(dict) | see `defaults/main.yml` ||
| vault_cluster_port | integer | 8201 | standard port for clustering |
| vault_dirs | list(dict) | see `defaults/main.yml` ||
| vault_etc_dir | UnixPath | `/etc/vault` | where the config lives |
| vault_format | string | zip | used to form the name of the archive to download |
| vault_lib_dir | UnixPath | `/var/lib/vault` | data area (if not using Consul) |
| vault_log_dir | UnixPath | `/var/log/vault` | log files (if used) |
| vault_protocol | string | 'http' ||
| vault_role | string | client | ...or server |
| vault_state | string | started | state of the service |
| vault_storage_dir | UnixPath | if `vault_storage_type`=raft, where to keep data, probably under `vault_lib_dir` |
| vault_state_type | string | raft | oneOf(consul, raft) |
| vault_version | SemVer | 1.2.3 | version to run |

## Optional variables
| Name | Type | Purpose |
| -----| ---- | ------- |
| vault_consul_token | UUID | used if Vault uses Consul as its backend and Consul uses ACLs |

## Role Dependencies
- `ansible-role-hashicorp-common`

## To Do
- HI : Run service using acct=vault
- MED : Use Let's Encrypt certificates

****
