Below some usefull docker images (some of them are home-made ✍, please open an issue if any error) :

**Raspbian base**
> [resin/rpi-raspbian](https://hub.docker.com/r/resin/rpi-raspbian/)

**Airplay** - *For streaming iOS devices on raspberry without any Apple TV*
> [dweidenfeld/armhf-airplay](https://hub.docker.com/r/dweidenfeld/armhf-airplay/)

**Airsonos** - *For streaming music on Sonos products*
> [fstehle/rpi-airsonos](https://github.com/fstehle/docker-rpi-airsonos) based on [stephen/airsonos](https://github.com/stephen/airsonos) project

**Hubot** - *Bot for chatting with a slack bot for talking with raspberry*
> [matthiasg/rpi-hubot](https://github.com/openwebcraft/rpi-hubot)

**Jeedom** ✍ - For managing IoT
Inspired by :

> [jeedom/core](https://github.com/jeedom/core/blob/beta/install/install.sh)

> [sbeuzit/docker-rpi-jeedom](https://github.com/sbeuzit/docker-rpi-jeedom/blob/master/jeedom/Build/Dockerfile)

**Nodered** ✍ - For wiring hardware devices
Inspired by official doc :

> [node-red/node-red](https://github.com/node-red/node-red)

**Plex Media Server** - *For running plex media server on raspberry letting shared picture, movies or anything else*
> [besn0847/arm-plex](https://github.com/besn0847/arm-plex)

**Portainer.io** - *For managing docker containers in a UI*
> sudo docker run -d --name="Portainer" --restart always -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer
