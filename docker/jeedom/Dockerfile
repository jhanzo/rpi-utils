FROM resin/rpi-raspbian

ENV HOME /root

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install wget

RUN wget https://raw.githubusercontent.com/jhanzo/rpi-utils/master/docker/jeedom/install.sh && \
    chmod +x install.sh && \
    ./install.sh

EXPOSE 80
