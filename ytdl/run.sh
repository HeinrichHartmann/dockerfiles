docker run -d --name youtube-dl -e MY_ID=user -e MY_PW=1234 -v /share/hhartmann/garage/Videos/ytdl:/downfolder -p 8085:8085 modenaf360/youtube-dl-nas
