FROM resin/rpi-raspbian:jessie

MAINTAINER Tit Petric <black@scene-si.org>

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget && \
    wget -q -O - http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key | apt-key add - && \
    wget -q -O - http://repo.mosquitto.org/debian/mosquitto-jessie.list > /etc/apt/sources.list.d/mosquitto-jessie.list && \
    apt-get update && apt-get install -y mosquitto && rm -rf /var/lib/apt/lists/* && \
    adduser --system --disabled-password --disabled-login mosquitto

COPY config /mqtt/config

VOLUME ["/mqtt/config", "/mqtt/data", "/mqtt/log"]

EXPOSE 1883 9001

CMD /usr/sbin/mosquitto -c /mqtt/config/mosquitto.conf
