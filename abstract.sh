#!/bin/bash

#Configuration
#-----------------
#specify your pictures directory
picdir=$HOME/Pictures
#specify your environment
#de="ubuntu"
#de="gnome"
de="xfce"
#de="plasma"
#de="mate"
#de="lxde"
#de=cinnamon
#-----------------


cd $picdir
while [ 1 ]; do
	var=`curl 2>&1 /dev/null https://vlepy.github.io/feed.xml | grep abstract | grep -v scaled_ | grep png | awk -F ";" '{print $3}' | awk -F "&" '{print $1}' | tail -n 1 | awk -F "/" '{print $(NF)}'`
	curl -o $var `curl 2>&1 /dev/null https://vlepy.github.io/feed.xml | grep abstract | grep -v scaled_ | grep png | awk -F ";" '{print $3}' | awk -F "&" '{print $1}' | tail -n 1`
	md5sum_1=`md5sum $var | awk '{print $1}'`
	if [ $de == "ubuntu" ]; then
		gsettings set org.gnome.desktop.background picture-uri file:///$picdir/$var
	elif [ $de == "gnome" ]; then
		gsettings set org.gnome.desktop.background picture-uri file:///$picdir/$var
	elif [ $de == "plasma" ]; then
		qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'var allDesktops = desktops();print (allDesktops);for (i=0;i<allDesktops.length;i++) {d = allDesktops[i];d.wallpaperPlugin = "org.kde.image";d.currentConfigGroup = Array("Wallpaper", "org.kde.image", "General");d.writeConfig("Image", "file:///$picdir/$var")}'
	elif [ $de == "xfce" ]; then
		xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/last-image -n -t string -s "$picdir/$var"
	elif [ $de == "mate" ]; then
		dconf write /org/mate/desktop/background/picture-filename "$picdir/$var"
	elif [ $de == "lxde" ]; then
		pcmanfm --set-wallpaper="$picdir/$var"
	elif [ $de == "cinnamon" ]; then
		gsettings set org.cinnamon.desktop.background picture-uri  "file:///$picdir/$var"
	fi
	
	sleep 1s
	
	curl -o temp.png `/dev/null https://vlepy.github.io/feed.xml | grep abstract | grep -v scaled_ | grep png | awk -F ";" '{print $3}' | awk -F "&" '{print $1}' | tail -n 1`
	md5sum_2=`md5sum temp.png | awk '{print $1}'`
	if [ "$md5sum_1" == "$md5sum_2" ]; then
		echo "No new abstracts."
		mv temp.png $var
	fi
done
