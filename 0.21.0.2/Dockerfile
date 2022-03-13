FROM debian:stretch-slim as builder

# VERSION of Elements Core to be download
ARG VERSION=0.21.0.2
ARG TARGETPLATFORM

RUN set -ex \
  && if [ "${TARGETPLATFORM}" = "linux/amd64" ]; then export TARGETPLATFORM=x86_64-linux-gnu; fi \
  && if [ "${TARGETPLATFORM}" = "linux/arm64" ]; then export TARGETPLATFORM=aarch64-linux-gnu; fi \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates wget \
	&& cd /tmp \
	&& wget -qO elements.tar.gz "https://github.com/ElementsProject/elements/releases/download/elements-$VERSION/elements-elements-$VERSION-$TARGETPLATFORM.tar.gz" \
	&& mkdir bin \
	&& tar -xzvf elements.tar.gz -C /tmp/bin --strip-components=2 "elements-elements-$VERSION/bin/elements-cli" "elements-elements-$VERSION/bin/elementsd"

FROM debian:stretch-slim

COPY --from=builder "/tmp/bin" /usr/local/bin

RUN groupadd -r elements && useradd -r -m -g elements elements

USER elements

RUN mkdir -p "$HOME/.elements/" \
  && chown -R elements:elements /home/elements/.elements

ENTRYPOINT [ "elementsd" ]


