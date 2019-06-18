FROM ubuntu:18.04

RUN apt-get update && apt-get install -y wget

RUN mkdir -p /tmp /scripts

ADD install /scripts

RUN /scripts/install && rm -rf /tmp /scripts

EXPOSE 18884 18886

ENTRYPOINT ["liquidd", "-datadir=/config"]