#!/bin/bash

docker image build . -t airline-app:v4
docker image save -o airline-v4.tar airline-app:v4
