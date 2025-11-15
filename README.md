# bitwarden-cli

This repository contains a container image intended to be used as a [Bitwarden](https://bitwarden.com) "server" for [external-secrets](https://external-secrets.io/latest/examples/bitwarden).

It expects two environment variables, as per [the official documentation](https://bitwarden.com/help/cli/#using-an-api-key):

- `BW_CLIENTID`
- `BW_CLIENTSECRET`

Optionally you can also specify a different server with `BW_SERVER`.

It will listen on port `8087` by default, overridable with `BW_PORT`

### Vault sync

To sync the vault on an interval, set up a health check with the following:

	wget -q http://127.0.0.1:8087/sync?force=true --post-data='' || exit 1
