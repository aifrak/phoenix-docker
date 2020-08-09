# Phoenix in Docker

Installation of dockerized Phoenix / Elixir (Debian).

[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/aifrak/phoenix)](https://hub.docker.com/r/aifrak/phoenix/builds)
[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/aifrak/phoenix?color=orange&sort=semver)](https://hub.docker.com/r/aifrak/phoenix/tags)
[![Docker Pulls](https://img.shields.io/docker/pulls/aifrak/phoenix?color=yellow)](https://hub.docker.com/r/aifrak/phoenix/)
[![GitHub](https://img.shields.io/github/license/aifrak/phoenix-docker?color=blue)](https://github.com/aifrak/phoenix-docker/blob/master/LICENSE)

## How to use this image

Short syntax:

```
docker run --rm -it \
  -v [DIR]:/app \
  aifrak/phoenix
```

Long syntax:

```
docker run --rm -it \
  -p [PORT]:[PORT] \
  -v [DIR]:/app \
  aifrak/phoenix
```

This example runs the image with the current host directory inside the container and with port 4000 exposed.

```
docker run --rm -it \
  -p 4000:4000 \
  -v $(pwd):/app \
  aifrak/phoenix
```

### `PORT`

Port to expose. If `-p` is not set, 4000 by default.

### `DIR`

Directory of your project on the host. Its content will copied inside the container under `/app`.

### `/app`

Directory in the container which will contain your Phoenix project.

It is also the default working directory of the container.

### Default user

The default user used by the container is `app-user`. Its user folder is also created inside the `/home`.

## Docker

```
docker pull aifrak/phoenix
```

## Quick references

__Docker hub__: https://hub.docker.com/r/aifrak/phoenix \
__Github__: https://github.com/aifrak/phoenix-docker

## Inspirations

[Elixir image by bitwalker](https://github.com/bitwalker/alpine-elixir) \
[Phoenix guide](https://hexdocs.pm/phoenix)

## Technologies

[Phoenix](https://www.phoenixframework.org/) \
[Elixir](https://elixir-lang.org/) \
[Erlang](https://www.erlang.org/) \
[NodeJS](https://nodejs.org)
