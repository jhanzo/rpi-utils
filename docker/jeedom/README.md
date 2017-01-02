#Jeedom (for rulling them all)

This folder is about Jeedom configuration.

Technically, it is only a webserver (nginx) configuration from [jeedom/core](https://github.com/jeedom/core) sources.

###Database configuration

According to general Docker rules, this image doesn't include any MySQL server instance for having only atomic containers. Of course, mysql-client is included.

So you could configure how to access to your database in jeedom-mysql/jeedom_my.cnf.

For creating Jeedom database you have to build and run rpi-mysql with your **settings** (please see `-e` flags below) :

```bash
docker run -d -p 3306:3306 \
-v /home/subena/rpi-mysql/docker/jeedom/jeedom-mysql:/etc/mysql/conf.d \
-e MYSQL_ROOT_PASSWORD=toor \
-e MYSQL_DATABASE=jeedom \
-e MYSQL_USER=jeedom \
-e MYSQL_PASSWORD=jeedom \
--name rpi-mysql tobi312/rpi-mysql
```
