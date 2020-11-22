#!/bin/bash

docker stop registry
docker rm registry
# https://docs.docker.com/registry/deploying/
docker run -d -p 5000:5000 \
       --restart=unless-stopped --name registry \
       -v "$(pwd)"/certs:/certs \
       -e REGISTRY_HTTP_ADDR=0.0.0.0:5000 \
       -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
       -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
       -v /rpool/docker-registry:/var/lib/registry \
       registry:2
