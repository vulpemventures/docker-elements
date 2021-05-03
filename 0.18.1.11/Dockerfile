FROM debian:stable-slim AS builder

# VERSION of Elements Core to be build
ARG VERSION=0.18.1.11

RUN apt-get update && apt-get install -y wget curl libzmq3-dev build-essential libtool autotools-dev automake pkg-config bsdmainutils python3 libssl-dev libevent-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-test-dev libboost-thread-dev libdb-dev libdb++-dev libdb4.8

RUN wget -qO- https://github.com/ElementsProject/elements/archive/elements-$VERSION.tar.gz | tar -xvz -C /tmp

RUN cd /tmp/elements-elements-$VERSION/depends && make NO_QT=1 NO_UPNP=1 && cd .. && \
  ./autogen.sh && \
  ./configure --without-gui --with-incompatible-bdb && \
  make && \
  mv ./src/elementsd /elementsd && \
  mv ./src/elements-cli /elements-cli

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