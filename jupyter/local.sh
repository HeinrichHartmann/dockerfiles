#!/bin/bash
# https://www.howtogeek.com/howto/30184/10-ways-to-generate-a-random-password-from-the-command-line/
# TOKEN=$(tr -cd '[:alnum:]' < /dev/urandom | fold -w32 | head -n1)
TOKEN=""
echo "#"
echo "# jupyterc"
echo "#"
echo "# starting jupyter notebook&lab ... "
jupyter notebook --ip 0.0.0.0 --port 9999 --NotebookApp.token="$TOKEN" &> notebook.log &
jupyter lab --ip 0.0.0.0 --port 9998 --NotebookApp.token="$TOKEN" &> lab.log &
sleep 3
bash
