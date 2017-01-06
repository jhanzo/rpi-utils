[Node-red](https://github.com/node-red/node-red) by IBM is an open-source project for managing workflows in order to wire multiple hardware devices.

### Installation

For building image, please run :
```bash
docker build --tag=rpi-nodered .
```

For running container from previously compiled image, please run :
```bash
docker run -dt -p 1880:1880 --name rpi-nodered rpi-nodered /bin/bash -c 'node-red'
```
