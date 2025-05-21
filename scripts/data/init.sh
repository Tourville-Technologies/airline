#!/bin/sh
echo "===== INITIALIZING (if this fails, run again until it works) ====="
cd /home/airline/airline/airline-data
sbt publishLocal
echo "===== DONE ====="
