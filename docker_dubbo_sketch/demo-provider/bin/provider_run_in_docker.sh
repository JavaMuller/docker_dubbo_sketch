#!/bin/bash
cd `dirname $0`

SERVER_NAME=`sed '/application.name/!d;s/.*=//' conf/app.properties | tr -d '\r'`
JAR_FILE=`sed '/application.jar/!d;s/.*=//' conf/app.properties | tr -d '\r'`
JAR_CONF=`sed '/application.conf/!d;s/.*=//' conf/app.properties | tr -d '\r'`
SERVER_PORT=`sed '/application.port/!d;s/.*=//' conf/app.properties | tr -d '\r'`

LOGS_DIR="logs"


DUBBO_OPTS=""
if [ -n "$1" ]; then 
	SERVER_PORT=$1
fi 
DUBBO_OPTS="-Ddubbo.protocol.port=$SERVER_PORT"


if [ ! -d $LOGS_DIR ]; then
    mkdir $LOGS_DIR
fi
STDOUT_FILE=$LOGS_DIR/stdout.$SERVER_PORT.log

JAVA_OPTS=" -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true "

JAVA_MEM_OPTS=""
BITS=`java -version 2>&1 | grep -i 64-bit`
if [ -n "$BITS" ]; then
    JAVA_MEM_OPTS=" -server -Xmx2g -Xms2g -Xmn256m -XX:PermSize=128m -Xss256k -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+UseCMSCompactAtFullCollection -XX:LargePageSizeInBytes=128m -XX:+UseFastAccessorMethods -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=70 "
else
    JAVA_MEM_OPTS=" -server -Xms1g -Xmx1g -XX:PermSize=128m -XX:SurvivorRatio=2 -XX:+UseParallelGC "
fi



echo -e "Starting $SERVER_NAME ...\c"
nohup java $JAVA_OPTS -Duser.timezone=GMT+08 $JAVA_MEM_OPTS $DUBBO_OPTS -jar $JAR_FILE $JAR_CONF > $STDOUT_FILE 2>&1 &

COUNT=0
while [ $COUNT -lt 1 ]; do    
    echo -e ".\c"
    sleep 1 
    COUNT=`ps -ef | grep java | grep "$JAR_FILE" | grep "$SERVER_PORT" | awk '{print $2}' | wc -l`
    
    if [ $COUNT -gt 0 ]; then
        break
    fi
done

echo "OK!"
PIDS=`ps -ef | grep java | grep "$JAR_FILE" | grep "$SERVER_PORT" | awk '{print $2}'`
echo "PID: $PIDS"
echo "STDOUT: $STDOUT_FILE"

while [ true ]; do
 sleep 60  
done 
