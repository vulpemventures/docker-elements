FROM debian:bookworm-slim AS builder

# VERSION of Elements Core to be download
ARG VERSION=23.3.0
ARG TARGETPLATFORM

RUN set -ex \
  && if [ "${TARGETPLATFORM}" = "linux/amd64" ]; then export TARGETPLATFORM=x86_64-linux-gnu; fi \
  && if [ "${TARGETPLATFORM}" = "linux/arm64" ]; then export TARGETPLATFORM=aarch64-linux-gnu; fi \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates wget \
	&& cd /tmp \
	&& wget -qO elements.tar.gz "https://github.com/ElementsProject/elements/releases/download/elements-$VERSION/elements-$VERSION-$TARGETPLATFORM.tar.gz" \
	&& mkdir bin \
	&& tar -xzvf elements.tar.gz -C /tmp/bin --strip-components=2 "elements-$VERSION/bin/elements-cli" "elements-$VERSION/bin/elementsd"

FROM debian:stretch-slim

# $USER name, and data $DIR to be used in the `final` image
ARG USER=elements
ARG DIR=/home/elements

COPY --from=builder "/tmp/bin" /usr/local/bin

# NOTE: Default GID == UID == 1000
RUN adduser --disabled-password \
            --home "$DIR/" \
            --gecos "" \
            "$USER"

USER $USER

# Prevents `VOLUME $DIR/.elements/` being created as owned by `root`
RUN mkdir -p "$DIR/.elements/"

# Expose volume containing all `elementsd` data
VOLUME $DIR/.elements/


ENTRYPOINT [ "elementsd" ]


