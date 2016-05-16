#!/bin/bash
cd `dirname $0`
DEPLOY_DIR=`pwd`

SERVER_NAME=`sed '/application.name/!d;s/.*=//' conf/app.properties | tr -d '\r'`
DATA_DIR=`sed '/data.volumes/!d;s/.*=//' conf/app.properties | tr -d '\r'`
SERVER_PORT=`sed '/application.port/!d;s/.*=//' conf/app.properties | tr -d '\r'`

SERVER_PORT=8000
if [ -n "$1" ]; then 
	SERVER_PORT=$1
fi 


WEB_APPS_DIR=$DEPLOY_DIR/webapps

docker run -d --name $SERVER_NAME-$SERVER_PORT -p $SERVER_PORT:8080 \
-v /etc/localtime:/etc/localtime:ro \
-v $WEB_APPS_DIR:/usr/local/tomcat/webapps \
-v $DATA_DIR:/home/html \
-v $DEPLOY_DIR/conf/server.xml:/usr/local/tomcat/conf/server.xml \
-v $DEPLOY_DIR/conf/catalina.sh:/usr/local/tomcat/bin/catalina.sh \
--restart=always docker.io/tomcat:7-jre7 
