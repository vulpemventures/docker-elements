FROM ubuntu:18.04

RUN apt-get update && apt-get install --yes curl wget

RUN mkdir -p /tmp /script

ADD install /script

RUN /script/install

EXPOSE 18884
STOPSIGNAL SIGINT

ENTRYPOINT ["liquidd"]
CMD ["-datadir=/config"]