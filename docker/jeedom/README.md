#Jeedom (for rulling them all)

This folder is about Jeedom configuration.

Technically, it is only a webserver (nginx) configuration from [jeedom/core](https://github.com/jeedom/core) sources.

###Database configuration

According to general Docker rules, this image doesn't include any MySQL server instance for having only atomic containers. Of course, mysql-client is included.

So you could configure how to access to your database in the following Dockerfile with ENV vars (`MYSQL_...`). 

For creating Jeedom required database you have to configure one as official doc described it :

According to [install/install.sh](https://github.com/jeedom/core/blob/beta/install/install.sh), you should rely on jeedom_my.cnf and a database named `jeedom` with an user named `jeedom`.
