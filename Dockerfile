FROM node:14.16.0-buster-slim as node
FROM hexpm/elixir:1.11.3-erlang-23.2.7-debian-buster-20210208 as build-phoenix

# install packages as suggested from https://hexdocs.pm/phoenix/installation.html
RUN set -ex \
  && apt-get update \
  && apt-get install --yes --no-install-recommends \
  # core packages
  ca-certificates \
  # erlang packages
  erlang-dev \
  erlang-dialyzer \
  erlang-parsetools \
  # live code reloading
  inotify-tools \
  # clean cache and temporary files
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  # certificates
  && update-ca-certificates --fresh

ENV APP_USER=app-user
ENV APP_USER_GROUP=www-data
ENV APP_DIR=/app
ENV APP_USER_HOME=/home/$APP_USER

RUN \
  # create non root user
  adduser --quiet --disabled-password \
  --shell /bin/bash \
  --gecos "App user" $APP_USER \
  --ingroup $APP_USER_GROUP \
  # init app folder
  && mkdir -p $APP_DIR \
  && chown -R $APP_USER:$APP_USER_GROUP $APP_DIR

USER $APP_USER

# install hex, rebar and phoenix
ENV PHOENIX_VERSION=1.5.8
RUN mix local.hex --force \
  && mix local.rebar --force \
  && mix archive.install --force hex phx_new $PHOENIX_VERSION

# copy node binaries
COPY --from=node /usr/local/bin /usr/local/bin/
COPY --from=node /usr/local/include /usr/local/include/
COPY --from=node /usr/local/lib /usr/local/lib/

# always install latest versions of Hex and Rebar
# inspired from https://hub.docker.com/r/bitwalker/alpine-elixir/dockerfile
ONBUILD RUN mix do local.hex --force, local.rebar --force

VOLUME ["${APP_DIR}"]

WORKDIR $APP_DIR

EXPOSE 4000

CMD ["bash"]
