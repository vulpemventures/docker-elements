FROM debian:stable-slim AS builder

RUN apt-get update && apt-get install -y wget curl libzmq3-dev build-essential libtool autotools-dev automake pkg-config bsdmainutils python3 libssl-dev libevent-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-test-dev libboost-thread-dev libdb-dev libdb++-dev

RUN mkdir -p /tmp /scripts

ADD compile /scripts

RUN chmod +x /scripts/compile && /scripts/compile

FROM debian:stable-slim

RUN apt-get update && apt-get install -y libboost-filesystem-dev \
  libboost-thread-dev \
  libevent-dev \
  libsodium-dev \
  libzmq3-dev \
  libdb-dev \
  libdb++-dev

RUN useradd -ms /bin/bash elements

USER elements

COPY --from=builder /elementsd /usr/local/bin/elementsd
COPY --from=builder /elements-cli /usr/local/bin/elements-cli

# Prevents `VOLUME $HOME/.elements/` being created as owned by `root`
RUN mkdir -p "$HOME/.elements/"

ENTRYPOINT [ "elementsd" ]