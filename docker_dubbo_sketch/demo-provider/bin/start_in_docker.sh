#!/bin/bash
cd `dirname $0`
DEPLOY_DIR=`pwd`

SERVER_NAME=`sed '/application.name/!d;s/.*=//' conf/app.properties | tr -d '\r'`
DATA_DIR=`sed '/data.volumes/!d;s/.*=//' conf/app.properties | tr -d '\r'`

docker run -d --name $SERVER_NAME-$1 --net=host \
-v $DEPLOY_DIR:/home/work \
-v $DATA_DIR:/home/html \
docker.io/java:7-jre /home/work/provider_run_in_docker.sh $1

