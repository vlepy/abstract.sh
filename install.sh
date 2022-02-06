#!/bin/bash
#set your home directory path and specify your username
homedir=/home/wsky
username=wsky

cp ./abstract.sh /usr/local/bin
cp ./ksetwallpaper.py /usr/local/bin
cp ./abstract.desktop $homedir/.config/autostart/
cp ./abstract.desktop $homedir/.local/share/applications/
chown $username:$username $homedir/.config/autostart/abstract.desktop 
chown $username:$username $homedir/.local/share/applications/abstract.desktop
cp ./abstract.svg /usr/share/icons
echo "abstract.sh installed."
