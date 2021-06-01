FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
ARG DATA_DIRECTORY=/data
ENTRYPOINT [ "/run.sh" ]
VOLUME $DATA_DIRECTORY
RUN apt update \
    && apt install -y wget tor torsocks
COPY run.sh .
WORKDIR $DATA_DIRECTORY