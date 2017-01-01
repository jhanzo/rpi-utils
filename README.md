#Installation

## 0 - Raspbian on SDCard
Download latest release of Raspbian on : https://www.raspberrypi.org/downloads/raspbian/
Minimal version of raspbian should be better for installing only required packages.

Then for installing image on sd card : 
- On Windows, use [Win32DiskImager](http://lifehacker.com/how-to-clone-your-raspberry-pi-sd-card-for-super-easy-r-1261113524)
- On Unix, run `sudo dd if=raspbian_latest of=/dev/sde bs=1m` (with `lsblk` for listing device, put it in `of=...`) 
- On Mac, run `sudo dd if=raspbian_latest of=/dev/rdisk2 BS=1m` (with `diskutil list` for listing device, put it in `of=...`)

Raspberry is ready.

## 1 - Docker on Rpi

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

