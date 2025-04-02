#!/bin/sh
echo "===== START OF BACKEND ====="
cd /home/airline/airline/airline-data
SBT_OPTS="-Xmx8G -Xms512M -XX:+UseG1GC -XX:MaxMetaspaceSize=512M" sbt "runMain com.patson.MainSimulation"
echo "===== BACKEND SHUTDOWN WITH CODE $? ====="
