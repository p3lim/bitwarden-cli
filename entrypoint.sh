#!/bin/bash

set -eo pipefail

if [ -n "$BW_SERVER" ]; then
  bw config server "$BW_SERVER"
fi

if [ -n "$BW_CLIENTID" ] && [ -n "$BW_CLIENTSECRET" ]; then
  export BW_SESSION="$(bw login --apikey --raw)"
fi

bw unlock --check

echo "Running 'bw serve' on port ${BW_PORT:-8087}'
bw serve --hostname 0.0.0.0 --port ${BW_PORT:-8087}
