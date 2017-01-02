FROM resin/rpi-raspbian

#Inspired by jeedom core official documentation : https://github.com/jeedom/core/blob/beta/install/install.sh
MAINTAINER subena.io@gmail.com

MYSQL_PASSWORD $(awk '/^password/{print $3}' jeedom-mysql/jeedom_my.cnf)

#################
# System update #
#################

RUN apt-get update
RUN apt-get -y dist-upgrade

#Dependencies
RUN apt-get -y install mysql-server phpmyadmin
RUN apt-get autoremove

#######################
# Jeedom requirements #
#######################

RUN echo "DROP USER 'jeedom'@'localhost';" | mysql -uroot -p${MYSQL_ROOT_PASSWD} && \
  echo "CREATE USER 'jeedom'@'localhost' IDENTIFIED BY jeedom;" | mysql -uroot -p${MYSQL_ROOT_PASSWD} && \
  echo "DROP DATABASE IF EXISTS jeedom;" | mysql -uroot -p${MYSQL_ROOT_PASSWD} && \
  echo "CREATE DATABASE jeedom;" | mysql -uroot -p${MYSQL_ROOT_PASSWD} && \
  echo "GRANT ALL PRIVILEGES ON jeedom.* TO 'jeedom'@'%';" | mysql -uroot -p${MYSQL_ROOT_PASSWD}

# Start mysql service
CMD /usr/bin/mysqld_safe
