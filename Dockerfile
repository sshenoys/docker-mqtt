FROM ubuntu:14.04

MAINTAINER sshenoy
ENV MQTT_VERSION 1.4.8

RUN adduser --disabled-password --gecos "" mosquitto
#Install packages wget
RUN apt-get update && apt-get install -y wget && \
        apt-get install -y build-essential libwrap0-dev libssl-dev libc-ares-dev uuid-dev xsltproc && \
        cd /home/mosquitto && \
        wget http://mosquitto.org/files/source/mosquitto-$MQTT_VERSION.tar.gz && \
        tar xvzf mosquitto-$MQTT_VERSION.tar.gz && \
        cd mosquitto-$MQTT_VERSION && make install &&  \
        cp /etc/mosquitto/mosquitto.conf.example /etc/mosquitto/mosquitto.conf
        
        
RUN mkdir -p /mqtt/config /mqtt/data /mqtt/log /var/lib/mosquitto/
# COPY config /mqtt/config
RUN chown mosquitto:mosquitto /var/lib/mosquitto/ -R
VOLUME ["/mqtt/config", "/mqtt/data", "/mqtt/log"]


EXPOSE 1883 9001

CMD ["mosquitto", "-c", "/etc/mosquitto/mosquitto.conf"]

