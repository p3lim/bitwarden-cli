FROM debian:12.11-slim

ENV BW_VERSION=2025.9.0
ENV DEBIAN_FRONTEND=noninteractive

RUN <<EOF
  apt-get update
  apt-get install -y --no-install-recommends wget unzip
  apt-get clean
  rm -rf /var/lib/apt/lists/*
  wget --no-verbose -O "https://github.com/bitwarden/clients/releases/download/cli-v${BW_VERSION}/bw-linux-${BW_VERSION}.zip"
  unzip "bw-linux-${BW_VERSION}.zip"
  rm -fv "bw-linux-${BW_VERSION}.zip"
  mv bw /usr/local/bin/
  apt-get remove unzip
EOF

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
