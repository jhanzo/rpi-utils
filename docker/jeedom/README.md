#Jeedom (for rulling them all)

This folder is about Jeedom configuration.

Technically, it is only a webserver (nginx) configuration from [jeedom/core](https://github.com/jeedom/core) sources.

###Database configuration

According to general Docker rules, this image doesn't include any MySQL server instance for having only atomic containers. Of course, mysql-client is included.

So you could configure how to access to your database in the following Dockerfile with ENV vars (`MYSQL_...`). 

For creating Jeedom required database you have to configure one as official doc described it :

According to [install/install.sh](https://github.com/jeedom/core/blob/beta/install/install.sh), you should adapt your db in this way :
```bash
   if [ -d /etc/mysql/conf.d ]; then
    	touch /etc/mysql/conf.d/jeedom_my.cnf
    	echo "[mysqld]" >> /etc/mysql/conf.d/jeedom_my.cnf
    	echo "key_buffer_size = 16M" >> /etc/mysql/conf.d/jeedom_my.cnf
		echo "thread_cache_size = 16" >> /etc/mysql/conf.d/jeedom_my.cnf
		echo "tmp_table_size = 48M" >> /etc/mysql/conf.d/jeedom_my.cnf
		echo "max_heap_table_size = 48M" >> /etc/mysql/conf.d/jeedom_my.cnf
		echo "query_cache_type =1" >> /etc/mysql/conf.d/jeedom_my.cnf
		echo "query_cache_size = 16M" >> /etc/mysql/conf.d/jeedom_my.cnf
		echo "query_cache_limit = 2M" >> /etc/mysql/conf.d/jeedom_my.cnf
		echo "query_cache_min_res_unit=3K" >> /etc/mysql/conf.d/jeedom_my.cnf
		echo "innodb_flush_method = O_DIRECT" >> /etc/mysql/conf.d/jeedom_my.cnf
		echo "innodb_flush_log_at_trx_commit = 2" >> /etc/mysql/conf.d/jeedom_my.cnf
		echo "innodb_log_file_size = 32M" >> /etc/mysql/conf.d/jeedom_my.cnf
    fi
```
And :
```bash	
  echo "DROP USER 'jeedom'@'localhost';" | mysql -uroot -p${MYSQL_ROOT_PASSWD} > /dev/null 2>&1
	mysql_sql "CREATE USER 'jeedom'@'localhost' IDENTIFIED BY '${MYSQL_JEEDOM_PASSWD}';"
	mysql_sql "DROP DATABASE IF EXISTS jeedom;"
	mysql_sql "CREATE DATABASE jeedom;"
	mysql_sql "GRANT ALL PRIVILEGES ON jeedom.* TO 'jeedom'@'%';"
```
