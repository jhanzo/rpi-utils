FROM resin/rpi-raspbian

#Inspired by sbeuzit/docker-rpi-jeedom 716,7MB
MAINTAINER subena.io@gmail.com

#################
# System update #
#################

RUN apt-get update
RUN apt-get -y dist-upgrade

RUN apt-get install nodered npm mosquitto mosquitto-clients

RUN cd ~/.node-red && \
  npm install node-red-node-mysql

EXPOSE 1880 1883
