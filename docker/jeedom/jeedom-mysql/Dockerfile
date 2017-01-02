FROM resin/rpi-raspbian

#Inspired by jeedom core official documentation : https://github.com/jeedom/core/blob/beta/install/install.sh
MAINTAINER subena.io@gmail.com

#################
# System update #
#################

RUN apt-get update
RUN apt-get -y dist-upgrade

#Dependencies
RUN apt-get -y install mysql-server mysql-client phpmyadmin
RUN apt-get autoremove

################
# MySQL Config #
################

#change mysql root password
RUN mysqladmin -u root password ${MYSQL_PASSWORD}

#######################
# Jeedom requirements #
#######################

RUN echo "DROP USER 'jeedom'@'localhost';" | mysql -uroot -p${MYSQL_PASSWORD} && \
  echo "CREATE USER 'jeedom'@'localhost' IDENTIFIED BY jeedom;" | mysql -uroot -p${MYSQL_PASSWORD} && \
  echo "DROP DATABASE IF EXISTS jeedom;" | mysql -uroot -p${MYSQL_PASSWORD} && \
  echo "CREATE DATABASE jeedom;" | mysql -uroot -p${MYSQL_PASSWORD} && \
  echo "GRANT ALL PRIVILEGES ON jeedom.* TO 'jeedom'@'%';" | mysql -uroot -p${MYSQL_PASSWORD}

# Start mysql service
ENTRYPOINT /etc/init.d/mysql start && /bin/bash

EXPOSE 3306
