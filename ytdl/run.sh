docker stop youtube-dl
docker rm youtube-dl
docker run -d --name youtube-dl\
       -v /share/hhartmann/garage/Videos/ytdl:/downfolder \
       -p 8085:8085 \
       docker.heinrichhartmann.net:5000/youtube-dl

docker logs -f youtube-dl
