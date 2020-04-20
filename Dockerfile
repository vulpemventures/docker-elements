FROM debian:stable-slim AS builder

RUN apt-get update && apt-get install -y wget

RUN mkdir -p /tmp /scripts

ADD install /scripts

RUN /scripts/install

FROM ubuntu:19.04

COPY --from=builder /elementsd /usr/bin/elementsd
COPY --from=builder /elements-cli /usr/bin/elements-cli

RUN useradd -ms /bin/bash ubuntu

USER ubuntu

EXPOSE 18884 18886

ENTRYPOINT ["elementsd", "-datadir=/config"]