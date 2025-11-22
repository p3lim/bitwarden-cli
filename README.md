# bitwarden-cli

This repository contains a container image intended to be used as a [Bitwarden](https://bitwarden.com) "server" for [external-secrets](https://external-secrets.io/latest/examples/bitwarden).

### Environment variables

These should be pretty much self-explanatory.

- `BW_USERNAME`
- `BW_PASSWORD`
- `BW_PASSWORD_FILE`
	- defaults to `/secrets/BW_PASSWORD`
	- this is recommended over `BW_PASSWORD` envvar
- `BW_SERVER`
	- defaults to whatever the Bitwarden CLI sets as a default
- `BW_PORT`
	- defaults to `8087`

### Usage

Follow the guide provided in the docs for external-secrets found here:  
<https://external-secrets.io/latest/examples/bitwarden>  

> It is **highly** recommended to deploy a network policy with this, otherwise the unlocked vault will be accessible by the entire cluster!

Substitute this image: `ghcr.io/p3lim/ghcr.io/p3lim/bitwarden-cli:VERSION`  
See the latest version tags here:  
<https://github.com/p3lim/bitwarden-cli/pkgs/container/bitwarden-cli>

### Vault sync

To sync the vault on an interval, set up a health check with the following:

	wget -q http://127.0.0.1:8087/sync?force=true --post-data='' || exit 1
