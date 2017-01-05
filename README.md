## Installation

### Raspbian on SDCard
Download latest release of Raspbian on : https://www.raspberrypi.org/downloads/raspbian/
Minimal version of raspbian should be better for installing only required packages.

Raspberry is ready after following [Raspbian official guide](https://www.raspberrypi.org/documentation/installation/installing-images/README.md).

### Docker on Rpi

Run simply following commands for updating OS and dowloading required packages :
```bash
#download Docker for Raspberry
curl -sSL https://get.docker.com | sh
#add pi user to docker group
sudo usermod -aG docker pi
#enable docker service on rpi boot
sudo systemctl enable docker.service
```
More info on [official blog](https://www.raspberrypi.org/blog/docker-comes-to-raspberry-pi/).

## Docker cheatsheets
- https://docs.docker.com/engine/reference/builder/
- https://github.com/wsargent/docker-cheat-sheet
- http://ricostacruz.com/cheatsheets/docker.html

## Security Access

For extrem security access, install OpenVPN. 

A good way to achieve this is [PiVPN](https://github.com/pivpn/pivpn) (very easy install).
