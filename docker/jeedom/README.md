#Jeedom (for rulling them all)

This folder is about Jeedom configuration.

Technically, it is only a webserver (nginx) configuration from [jeedom/core](https://github.com/jeedom/core) sources.

###Database configuration

According to general Docker rules, this image doesn't include any MySQL server instance for having only atomic containers. Of course, mysql-client is included.

So you could configure how to access to your database in jeedom-mysql/jeedom_my.cnf.

For creating Jeedom database you have to build and run rpi-mysql with your **settings** (please see `-e` flags below) :

```bash
docker run -d -p 3306:3306 \
-v /home/subena/rpi-utils/docker/jeedom/jeedom-mysql:/etc/mysql/conf.d \
-e MYSQL_ROOT_PASSWORD=toor \
-e MYSQL_DATABASE=jeedom \
-e MYSQL_USER=jeedom \
-e MYSQL_PASSWORD=jeedom \
-e MYSQL_PORT=3306 \
--name rpi-mysql tobi312/rpi-mysql
```

If needed, install required database from your local :
```bash
mysql -uroot -ptoor -h 127.0.0.1 jeedom < jeedom-mysql/install.sql
```

###Jeedom configuration

Build Jeedom Docker image thanks to :
```bash
docker build —tag=jeedom .
```

And then run a Jeedom container link with previous mysql container :
```bash
docker run -dt -p 80:80 -p 8083:8083 --link rpi-mysql:mysql --name rpi-jeedom rpi-jeedom
```
###Access Jeedom

Finally Go to : 

> http://SERVER_NAME:PORT

You should be redirected to `install/setup.php`.

If any error about Cron just run displayed cmd in terminal.

Filled all information about you DB server and let you driving.
