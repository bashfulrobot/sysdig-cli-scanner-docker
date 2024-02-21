# Sysdig Cli Scanner

This is an unofficial dockerfile to build the `sysdig-cli-scanner` for x86 on an Alpline base.

This is mostly used for reference, however does work.

## Usage


### Build

If pushing to dockerhub you will be prompted for your dockerhub ID and PAT.


```bash

# Build local
./build-docker.sh

# Build local and push to dockerhub
./build-docker.sh -p
```

### Run

```bash
docker run --rm bashfulrobot/sysdig-cli-scanner:latest --help

```

## To Do

- Move the build into Github Actions
- Publish to the GitHub Repo vs Docker Hub
