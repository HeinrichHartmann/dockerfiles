IMAGE=docker.heinrichhartmann.net:5000/heinrichhartmann/conda

docker stop $IMAGE
docker rm $IMAGE

docker run  --name "conda" \
       -d --restart unless-stopped \
       -p 9999:9999 \
       -v /:/work/root \
       -v /share:/work/share \
       $IMAGE \
       jupyter notebook --port 9999 --ip 0.0.0.0

docker logs -f $IMAGE
