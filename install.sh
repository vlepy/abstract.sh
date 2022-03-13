#!/bin/bash
#set your home directory path specify your username\
#in case you use mac, don't use this script, just add abstract.sh to your autostart
homedir=/home/wsky
username=wsky

cp ./abstract.sh /usr/local/bin
cp ./ksetwallpaper.py /usr/local/bin
cp ./abstract.desktop $homedir/.config/autostart/
chown $username:$username $homedir/.config/autostart/abstract.desktop 
cp ./abstract.svg /usr/share/icons
echo "abstract.sh installed. You can relog now."
