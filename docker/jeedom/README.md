#Jeedom (for rulling them all)

This folder is about Jeedom configuration.

Technically, it is only a webserver (nginx) configuration from [jeedom/core](https://github.com/jeedom/core) sources.

###Database configuration

According to general Docker rules, this image doesn't include any MySQL server instance for having only atomic containers. Of course, mysql-client is included.

So you could configure how to access to your database in the following Dockerfile with ENV vars (`MYSQL_...`). 

For creating Jeedom required database you have to configure one as official doc described it :

According to [install/install.sh](https://github.com/jeedom/core/blob/beta/install/install.sh), based on jeedom_my.cnf, you should adapt your db in this way :
```bash	
  echo "DROP USER 'jeedom'@'localhost';" | mysql -uroot -p${MYSQL_ROOT_PASSWD} > /dev/null 2>&1
	mysql_sql "CREATE USER 'jeedom'@'localhost' IDENTIFIED BY '${MYSQL_JEEDOM_PASSWD}';"
	mysql_sql "DROP DATABASE IF EXISTS jeedom;"
	mysql_sql "CREATE DATABASE jeedom;"
	mysql_sql "GRANT ALL PRIVILEGES ON jeedom.* TO 'jeedom'@'%';"
```
