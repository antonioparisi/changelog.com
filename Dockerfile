FROM circleci/elixir:1.6-node

USER root

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y ffmpeg \
    && which ffmpeg \
    && rm -rf /var/lib/apt/lists/*

RUN mix do local.rebar --force, local.hex --force

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix do deps.get, compile
RUN cd assets && yarn install
