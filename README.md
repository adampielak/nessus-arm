# Nessus for ARM64

Docker container for running Tenable Nessus on ARM64-based systems such as Apple Silicon Macs.

Tested on:
- Kali Linux 2025.3 VM
- Host: Apple MacBook Air M1

## Features

- ARM64 / Apple Silicon compatible
- Persistent Nessus data volume
- Minimal Ubuntu 24.04 base image
- Automatic service restart
- Docker healthcheck support

## Requirements

- Docker Engine 24+
- ARM64 host or VM

## Build

```bash
docker build --pull -t nessus-arm64 .
```

## Run

```bash
docker run -d \
  --name nessus \
  --restart unless-stopped \
  -p 8834:8834 \
  -v nessus-data:/opt/nessus/var/nessus \
  nessus-arm64
```

## Access

Open:

```text
https://127.0.0.1:8834
```

Complete the Nessus setup wizard and activate your license.

## Verify

Check container status:

```bash
docker ps
docker logs -f nessus
```

Check web interface:

```bash
curl -kI https://127.0.0.1:8834
```

## Stop

```bash
docker stop nessus
```

## Remove

```bash
docker rm -f nessus
```

## Notes

- Nessus data is stored persistently in the `nessus-data` Docker volume.
- First startup may take several minutes while plugins are initialized.
- Tested on Apple Silicon (M1/M2/M3) using ARM64 containers only.
- This project is intended for lab, testing, and internal security assessment environments.
