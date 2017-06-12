FROM resin/rpi-raspbian

#Inspired by sbeuzit/docker-rpi-jeedom 716,7MB
MAINTAINER subena.io@gmail.com

#################
# System update #
#################

RUN apt-get update --fix-missing
RUN apt-get -y dist-upgrade

RUN apt-get install build-essential npm mosquitto mosquitto-clients curl wget vim

RUN wget -qO- https://deb.nodesource.com/setup_7.x | sudo bash - && \
  sudo apt-get install -y nodejs

#RUN sudo npm install n -g && sudo n latest \
RUN  sudo npm install -g --unsafe-perm node-red && \
  sudo npm install -g --unsafe-perm node-red-admin && \
  sudo npm install -g node-red-node-mysql && \
  sudo npm install -g node-red-contrib-slack && \
  sudo npm install -g node-red-contrib-slackbot && \
  sudo npm install -g node-red-contrib-cron && \
  sudo npm install -g node-red-contrib-auth 

#copy settings to nodered config
COPY ./settings.js /root/.node-red/settings.js

EXPOSE 1880 1883
