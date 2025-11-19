FROM debian:13.2-slim

ENV BW_VERSION=2025.11.0
ENV DEBIAN_FRONTEND=noninteractive

# install bitwarden-cli
RUN <<EOF
  apt-get update
  apt-get install -y --no-install-recommends ca-certificates wget unzip
  apt-get clean
  rm -rf /var/lib/apt/lists/*
  wget --no-verbose "https://github.com/bitwarden/clients/releases/download/cli-v${BW_VERSION}/bw-linux-${BW_VERSION}.zip"
  unzip "bw-linux-${BW_VERSION}.zip"
  rm -fv "bw-linux-${BW_VERSION}.zip"
  mv bw /usr/local/bin/
  apt-get purge -y unzip
EOF

# run rootless
USER 1000
WORKDIR /bw
ENV HOME=/bw

# copy entrypoint and make it executable
COPY --chmod=0755 entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
