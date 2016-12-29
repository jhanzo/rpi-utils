FROM resin/rpi-raspbian

COPY install.sh /tmp/
COPY start.sh /tmp/start.sh

RUN chmod +x /tmp/install.sh && \
    /tmp/install.sh

CMD /tmp/start.sh

EXPOSE 80
