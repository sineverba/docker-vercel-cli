Docker Vercel CLI
=================

> Docker image to use Vercel cli without installing it

| CD / CI   | Status |
| --------- | ------ |
| Semaphore CI | [![Build Status](https://sineverba.semaphoreci.com/badges/docker-vercel-cli/branches/master.svg)](https://sineverba.semaphoreci.com/projects/docker-vercel-cli) |
| CircleCI | [![CircleCI](https://dl.circleci.com/status-badge/img/gh/sineverba/docker-vercel-cli/tree/master.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/sineverba/docker-vercel-cli/tree/master) |

## Available architectures

+ linux/arm64
+ linux/arm/v6
+ linux/arm/v7

## Setup for development

[![Open in Dev Containers](https://img.shields.io/static/v1?label=Dev%20Containers&message=Open&color=blue&logo=visualstudiocode)](https://vscode.dev/redirect?url=vscode://ms-vscode-remote.remote-containers/cloneInVolume?url=https://github.com/sineverba/docker-vercel-cli)

Or

1. Install VSCode extension "Dev Containers"

2. Clone and open up the repository in VSCode, then, you should see the following notification:

![VSCode popup](./.devcontainer/folder.webp)

3. Click on "Reopen in Container"

4. Enjoy! :smiling_face_with_heart_eyes:


## How to use

`$ docker run --rm -it sineverba/vercel-cli:1.5.0 vercel [COMMAND]`