docker-compose up &
while true;
do 
    curl --cacert ../ssl/heinrichhartmann.net-ca.crt --resolve 'test.heinrichhartmann.net:4443:127.0.0.1' https://test.heinrichhartmann.net:4443/index.html
    sleep 1
done
