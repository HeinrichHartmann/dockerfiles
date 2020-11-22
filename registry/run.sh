#!/bin/bash

# https://docs.docker.com/registry/deploying/
docker run -d -p 5000:5000 \
       --restart=unless-stopped --name registry \
       -v /rpool/docker-registry:/var/lib/registry \
       registry:2
