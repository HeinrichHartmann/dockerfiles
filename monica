docker stop monica monica-mysql
docker rm monica monica-mysql

docker run -d --name monica-mysql \
 -e MYSQL_RANDOM_ROOT_PASSWORD=true \
 -e MYSQL_DATABASE=monica \
 -e MYSQL_USER=homestead \
 -e MYSQL_PASSWORD=secret \
 "mysql:5.7"

docker run -d --name monica \
       -v /share/hhartmann/garage/var/monica-mysql:/var/lib/mysql \
       --link monica-mysql:mysql \
       -e DB_HOST=mysql \
       -p 8086:80 \
       monica
