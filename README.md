##Installation

### 0 - Raspbian on SDCard
Download latest release of Raspbian on : https://www.raspberrypi.org/downloads/raspbian/
Minimal version of raspbian should be better for installing only required packages.

Raspberry is ready after following [Raspbian official guide](https://www.raspberrypi.org/documentation/installation/installing-images/README.md).

### 1 - Docker on Rpi

Run directly following commands for updating OS and dowloading required packages :
```bash
#download Docker for Raspberry
curl -sSL https://get.docker.com | sh

#add pi user to docker group
sudo usermod -aG docker pi

#enable docker service
sudo systemctl enable docker.service
```

Docker cheatsheets : 
- https://docs.docker.com/engine/reference/builder/
- https://github.com/wsargent/docker-cheat-sheet
- http://ricostacruz.com/cheatsheets/docker.html

