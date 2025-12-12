FROM debian:13.2-slim

ARG BW_VERSION=2025.12.0
ARG BW_DIGEST=41b294121be7284d119f3ec905f163965b63dd328c9140b6304777e4f33364c0
ENV DEBIAN_FRONTEND=noninteractive

# install bitwarden-cli
RUN <<EOF
  apt-get update
  apt-get install -y --no-install-recommends ca-certificates wget unzip
  apt-get clean
  rm -rf /var/lib/apt/lists/*
  wget --no-verbose "https://github.com/bitwarden/clients/releases/download/cli-v${BW_VERSION}/bw-oss-linux-${BW_VERSION}.zip"
  echo "$BW_DIGEST bw-oss-linux-${BW_VERSION}.zip" | sha256sum -c -
  unzip "bw-oss-linux-${BW_VERSION}.zip"
  rm -fv "bw-oss-linux-${BW_VERSION}.zip"
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
