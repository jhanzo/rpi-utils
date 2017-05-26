FROM resin/rpi-raspbian

#Inspired by sbeuzit/docker-rpi-jeedom 716,7MB
MAINTAINER subena.io@gmail.com

#################
# System update #
#################

RUN apt-get update
RUN apt-get -y dist-upgrade

RUN apt-get install build-essential npm mosquitto mosquitto-clients curl

RUN sudo npm install n -g && sudo n latest && \ 
  sudo npm install -g --unsafe-perm node-red && \
  npm install -g node-red-node-mysql && \
  npm install -g node-red-contrib-slack && \
  npm install -g node-red-contrib-slackbot && \
  npm install -g node-red-contrib-cron && \
  npm install -g node-red-contrib-auth && \
  npm install -g node-red-contrib-store-reviews

EXPOSE 1880 1883
