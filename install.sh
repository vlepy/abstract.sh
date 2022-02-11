#!/bin/bash
#set your home directory path and specify your username
homedir=/home/wsky
username=wsky

cp ./abstract.sh /usr/local/bin
cp ./ksetwallpaper.py /usr/local/bin
cp ./abstract.desktop $homedir/.config/autostart/
chown $username:$username $homedir/.config/autostart/abstract.desktop 
cp ./abstract.svg /usr/share/icons
exec abstract.sh
echo "abstract.sh installed and running."
