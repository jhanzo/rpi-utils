#!/bin/bash

service mysql start && tail -F /var/log/mysql/error.log
service apache2 start && tail -F /var/log/apache2/error.log
