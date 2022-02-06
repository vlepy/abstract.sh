#!/bin/bash
#set your home directory path
homedir=/home/wsky

cp ./abstract.sh /usr/local/bin
cp ./ksetwallpaper.py /usr/local/bin
cp ./abstract.desktop $homedir/.config/autostart/
cp ./abstract.desktop $homedir/.local/share/applications/
chown $USER:$USER $homedir/.config/autostart/abstract.desktop 
chown $USER:$USER $homedir/.local/share/applications/abstract.desktop
cp ./abstract.svg /usr/share/icons
echo "abstract.sh installed."
