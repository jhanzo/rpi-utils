FROM resin/rpi-raspbian

#Inspired by sbeuzit/docker-rpi-jeedom 716,7MB
MAINTAINER subena.io@gmail.com

#################
# System update #
#################

RUN apt-get update
RUN apt-get -y dist-upgrade

RUN  apt-get install nodered

##############
# Supervisor #
##############
# https://docs.docker.com/engine/admin/using_supervisord/

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add crontab  when container is launched (to avoid the HARDLINKS issue)
COPY ./add_crontab /etc/supervisord/
RUN chmod +x /etc/supervisord/add_crontab

# Create log dir in case it is launched using tmpfs
# CMD ["/usr/bin/supervisord"]
COPY ./start_supervisord /
RUN chmod +x /start_supervisord

CMD ["/start_supervisord"]

EXPOSE 1880
