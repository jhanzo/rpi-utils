#!/bin/sh

WEBSERVER_HOME=/var/www/html
export MYSQL_ROOT_PASSWD=$(cat /dev/urandom | tr -cd 'a-f0-9' | head -c 15)
export MYSQL_JEEDOM_PASSWD=$(cat /dev/urandom | tr -cd 'a-f0-9' | head -c 15)

echo "----------------------------------------------------------"
echo "System Update "
echo "----------------------------------------------------------"
apt-get update

echo "----------------------------------------------------------"
echo "Install packages "
echo "----------------------------------------------------------"
apt-get install ntp ca-certificates unzip curl sudo cron apt-utils
apt-get -y install locate tar telnet wget logrotate fail2ban
apt-get -y install software-properties-common
apt-get -y install libexpat1 ssl-cert
apt-get -y install apt-transport-https
apt-get -y install libav-tools
apt-get -y install libsox-fmt-mp3 sox libttspico-utils
apt-get -y install smbclient htop iotop vim iftop
apt-get -y install dos2unix
apt-get -y install ntpdate
apt-get -y install espeak
apt-get -y install mbrola
apt-get -y install git
apt-get -y install python
apt-get -y install python-pip
apt-get -y install python-serial
apt-get -y install python-requests
apt-get -y install python-pyudev
apt-get -y install python-nut
apt-get -y install python-dev python-setuptools python-louie python-sphinx make build-essential libudev-dev g++ gcc python-lxml libjpeg-dev zlib-dev
apt-get -y install openvpn
apt-get install mysql-server mysql-client mysql-common
apt-get install libexpat1
apt-get install ssl-cert
apt-get install php5-common php5-cli php5-curl php5-json php5-mysql php5-gd
pip install enum-compat
pip install beautifulsoup4
pip install sphinxcontrib-blockdiag
pip install sphinxcontrib-actdiag
pip install sphinxcontrib-nwdiag
pip install sphinxcontrib-seqdiag
pip install urwid
pip install louie
pip install flask
pip install flask-restful
pip install flask-httpauth
pip install six

echo "----------------------------------------------------------"
echo "Database Setup "
echo "----------------------------------------------------------"
/etc/init.d/mysql start
echo "mysql-server mysql-server/root_password password ${MYSQL_ROOT_PASSWD}" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password ${MYSQL_ROOT_PASSWD}" | debconf-set-selections
mysqladmin -u root password ${MYSQL_ROOT_PASSWD}

echo "----------------------------------------------------------"
echo "Jeedom Installation "
echo "----------------------------------------------------------"
wget https://github.com/jeedom/core/archive/stable.zip -O /root/jeedom.zip
cp /root/jeedom.zip /tmp/jeedom.zip
mkdir -p ${WEBSERVER_HOME}
find ${WEBSERVER_HOME} ! -name 'index.html' -type f -exec rm -rf {} +
rm -rf /root/core-*
unzip -q /tmp/jeedom.zip -d /root/
if [ $? -ne 0 ]; then
	echo "Could not unzip archive - abort"
	exit 1
fi
cp -R /root/core-*/* ${WEBSERVER_HOME}
rm -rf /root/core-* > /dev/null 2>&1
rm /tmp/jeedom.zip

echo "----------------------------------------------------------"
echo "Jeedom Settings "
echo "----------------------------------------------------------"
apt-get install nginx nginx-common nginx-full
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
cp /etc/nginx/sites-available/default_ssl /etc/nginx/sites-available/default_ssl.bak
cp ${WEBSERVER_HOME}/install/nginx_default /etc/nginx/nginx.conf
rm /var/lib/mysql/ib_logfile*

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

echo "----------------------------------------------------------"
echo "Starting Services "
echo "----------------------------------------------------------"
/etc/init.d/mysql restart
/etc/init.d/nginx restart

echo "----------------------------------------------------------"
echo "Database Configuration "
echo "----------------------------------------------------------"
echo "DROP USER 'jeedom'@'localhost';" | mysql -uroot -p${MYSQL_ROOT_PASSWD} > /dev/null 2>&1
mysql_sql "CREATE USER 'jeedom'@'localhost' IDENTIFIED BY '${MYSQL_JEEDOM_PASSWD}';"
mysql_sql "DROP DATABASE IF EXISTS jeedom;"
mysql_sql "CREATE DATABASE jeedom;"
mysql_sql "GRANT ALL PRIVILEGES ON jeedom.* TO 'jeedom'@'%';"
cp ${WEBSERVER_HOME}/core/config/common.config.sample.php ${WEBSERVER_HOME}/core/config/common.config.php
sed -i "s/#PASSWORD#/${MYSQL_JEEDOM_PASSWD}/g" ${WEBSERVER_HOME}/core/config/common.config.php
sed -i "s/#DBNAME#/jeedom/g" ${WEBSERVER_HOME}/core/config/common.config.php
sed -i "s/#USERNAME#/jeedom/g" ${WEBSERVER_HOME}/core/config/common.config.php
sed -i "s/#PORT#/3306/g" ${WEBSERVER_HOME}/core/config/common.config.php
sed -i "s/#HOST#/localhost/g" ${WEBSERVER_HOME}/core/config/common.config.php
chmod 775 -R ${WEBSERVER_HOME}
chown -R www-data:www-data ${WEBSERVER_HOME}

echo "----------------------------------------------------------"
echo "Jeedom Configuration "
echo "----------------------------------------------------------"
php ${WEBSERVER_HOME}/install/install.php mode=force

if [ -f post-install.sh ]; then
	rm post-install.sh
fi
if [ -f /etc/armbian.txt ]; then
	wget https://raw.githubusercontent.com/jeedom/core/stable/install/OS_specific/armbian/post-install.sh
fi
if [ -f /usr/bin/raspi-config ]; then
	wget https://raw.githubusercontent.com/jeedom/core/stable/install/OS_specific/rpi/post-install.sh
fi
if [ -f post-install.sh ]; then
	chmod +x post-install.sh
	./post-install.sh
	rm post-install.sh
fi

echo "----------------------------------------------------------"
echo "Welcome to jeedom installer "
echo "Jeedom install version : stable "
echo "Webserver home folder : ${WEBSERVER_HOME} "
echo "----------------------------------------------------------"

rm -rf ${WEBSERVER_HOME}/index.html > /dev/null 2>&1

exit 0
