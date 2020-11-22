#!/bin/bash
docker stop jupyterd
docker rm jupyterd
docker run -d --restart=unless-stopped --name jupyterd \
       -p 127.0.0.1:9999:9999 -p 127.0.0.1:9998:9998 \
       -v $HOME:/work/home \
       -v /:/work/root \
       heinrichhartmann/jupyter /work/run/local.sh
