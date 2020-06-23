#!/bin/bash

useradd --home-dir /home/heinrich --create-home heinrich

chown root:root -R /etc/postfix
chown postfix:postfix -R /var/lib/postfix

postfix start && echo "Started Postfix" && sleep infinity
