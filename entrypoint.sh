#!/bin/bash

set -eo pipefail

if [ -n "$BW_SERVER" ]; then
  bw config server "$BW_SERVER"
fi

if [ -n "$BW_USERNAME" ]; then
  if [ -f "${BW_PASSWORD_FILE:-/secrets/BW_PASSWORD}" ]; then
    export BW_SESSOIN="$(bw login "$BW_USERNAME" --passwordfile "${BW_PASSWORD_FILE:-/secrets/BW_PASSWORD}" --raw)"
  elif [ -n "$BW_PASSWORD" ]; then
    export BW_SESSION="$(bw login "$BW_USERNAME" --passwordenv "$BW_PASSWORD" --raw)"
  fi
fi

bw unlock --check

echo "Running 'bw serve' on port ${BW_PORT:-8087}'
bw serve --hostname 0.0.0.0 --port ${BW_PORT:-8087}
