#!/bin/bash

appname=$1

docker run -td --name $appname dp-data 

docker run --volumes-from $appname --name $appname-mysql  -p 3306:3306  -d stdmysql /sbin/my_init 

docker run  --link $appname-mysql:mysqldb --name $appname-nginx  --volumes-from $appname -p 80:80  -d stdnginx /sbin/my_init 

docker run  --link $appname-mysql:mysqldb --name $appname-apache  --volumes-from $appname -p 81:80  -d stdapache 

docker run  --link $appname-mysql:mysqldb --link $appname-nginx:nginx --link $appname-apache:apache  --name $appname-utils --volumes-from $appname -p 2222:22  -d stdutils /sbin/my_init


echo " $appname - created "
