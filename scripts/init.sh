#download Docker for Raspberry
curl -sSL https://get.docker.com | sh

#add pi user to docker group
sudo usermod -aG docker pi

#enable docker service
sudo systemctl enable docker.service
