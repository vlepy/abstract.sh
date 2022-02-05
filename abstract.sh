#!/bin/bash
#specify your pictures directory
picdir=$HOME/Pictures
#specify your environment
#de="ubuntu"
#de="gnome"
de="xfce"
#de="plasma"
#de="mate"

cd $picdir
while [ 1 ]; do
	var=`curl 2>&1 /dev/null https://vlepy.github.io/feed.xml | grep abstract | grep -v scaled_ | grep png | awk -F ";" '{print $3}' | awk -F "&" '{print $1}' | tail -n 1 | awk -F "/" '{print $(NF)}'`
	if [ -f $picdir/$var ]; then
		echo "No new abstracts."
	else
		curl -o $var `curl 2>&1 /dev/null https://vlepy.github.io/feed.xml | grep abstract | grep -v scaled_ | grep png | awk -F ";" '{print $3}' | awk -F "&" '{print $1}' | tail -n 1`
		if [ $de == "ubuntu" ]; then
			gsettings set org.gnome.desktop.background picture-uri file:///$picdir/$var
		elif [ $de == "gnome" ]; then
			gsettings set org.gnome.desktop.background picture-uri file:///$picdir/$var
		elif [ $de == "plasma" ]; then
			qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript 'var allDesktops = desktops();print (allDesktops);for (i=0;i<allDesktops.length;i++) {d = allDesktops[i];d.wallpaperPlugin = "org.kde.image";d.currentConfigGroup = Array("Wallpaper", "org.kde.image", "General");d.writeConfig("Image", "file:///$picdir/$var")}'
		elif [ $de == "xfce" ]; then
			xfconf-query -c xfce4-desktop -p  /backdrop/screen0/monitor0/workspace0/last-image -s "$picdir/$var"
		elif [ $de == "mate"]; then
			dconf write /org/mate/desktop/background/picture-filename "$picdir/$var"
		fi
	fi
sleep 1h
done
