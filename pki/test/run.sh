# docker-compose up &

sudo docker run \
       -v "$(pwd)/html:/usr/share/nginx/html" \
       -v "$(pwd)/nginx.conf:/etc/nginx/nginx.conf" \
       -v "$(pwd)/../ssl/heinrichhartmann.net.crt:/etc/nginx/host.crt" \
       -v "$(pwd)/../secrets/heinrichhartmann.net.key:/etc/nginx/host.key" \
       -p "4443:443" \
       --rm -it nginx:1.15

while true;
do
     curl --cacert ../ssl/heinrichhartmann.net-ca.crt --resolve 'test.heinrichhartmann.net:4443:127.0.0.1' https://test.heinrichhartmann.net:4443/index.html
     sleep 1
done
