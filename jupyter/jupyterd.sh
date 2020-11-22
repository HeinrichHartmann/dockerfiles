#!/bin/bash

docker run -d --name jupyter \
       -p 127.0.0.1:9999:9999 -p 127.0.0.1:9998:9998 \
       -v $HOME:/home/jovyan/host/home \
       -v /:/home/jovyan/host/root \
       heinrichhartmann/jupyter /work/run/local.sh
