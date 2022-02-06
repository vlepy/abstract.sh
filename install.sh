#!/bin/bash
cp ./abstract.sh /usr/local/bin
cp ./ksetwallpaper.py /usr/local/bin
cp ./abstract.desktop /home/wsky/.config/autostart/
cp ./abstract.desktop /home/wsky/.local/share/applications/
chown $USER:$USER /home/wsky/.config/autostart/abstract.desktop 
chown $USER:$USER /home/wsky/.local/share/applications/abstract.desktop
cp ./nova.png /usr/share/icons
echo "abstract.sh installed."
