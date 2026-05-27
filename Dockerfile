#
#       Dockerfile for running Nessus on arm based hardware.
#       Author: Jannik Schmied
#       Tested on: Kali Linux 2023.3 VM (Apple Silicon M1 Max Host)
#       Modified by tick - tested on Kali Linux 2025.3
#
FROM ubuntu:24.04

ARG NESSUS_VERSION=10.12.0
ARG NESSUS_DEB=Nessus-${NESSUS_VERSION}-ubuntu1804_aarch64.deb
ARG NESSUS_URL=https://www.tenable.com/downloads/api/v2/pages/nessus/files/${NESSUS_DEB}

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Warsaw

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      iputils-ping \
      net-tools \
      tzdata \
 && curl -fsSL "$NESSUS_URL" -o "/tmp/${NESSUS_DEB}" \
 && dpkg -i "/tmp/${NESSUS_DEB}" \
 && rm -f "/tmp/${NESSUS_DEB}" \
 && apt-get purge -y --auto-remove curl \
 && rm -rf /var/lib/apt/lists/*

VOLUME ["/opt/nessus/var/nessus"]

EXPOSE 8834

HEALTHCHECK --interval=30s --timeout=5s --start-period=90s --retries=5 \
  CMD /opt/nessus/bin/nessuscli fix --get listen_port >/dev/null 2>&1 || exit 1

ENTRYPOINT ["/opt/nessus/sbin/nessusd"]
CMD ["-D"]
