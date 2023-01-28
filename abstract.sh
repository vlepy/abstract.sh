#!/bin/bash

#Configuration:
#-----------------
#specify your pictures directory
picdir=$HOME/Obrazy
#
#specify your environment
#de="gnome"
de="gnome-dark"
#de="xfce"
#de="plasma"
#de="mate"
#de="lxde"
#de="cinnamon"
#de="wmfeh"
#de="macos"
#-----------------

wallpaperset=0

if [ "$de" == "macos" ]; then
	alias md5sum='md5 -r'
fi

setWallpaper() {
	if [ "$de" == "gnome" ]; then
		gsettings set org.gnome.desktop.background picture-uri file:///$picdir/$vari
        elif [ "$de" == "gnome-dark" ]; then
                gsettings set org.gnome.desktop.background picture-uri-dark file:///$picdir/$var
	elif [ "$de" == "plasma" ]; then
		ksetwallpaper.py $picdir/$var
	elif [ "$de" == "xfce" ]; then
		xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/last-image -n -t string -s "$picdir/$var"
	elif [ "$de" == "mate" ]; then
		gsettings set org.mate.background picture-filename "$picdir/$var"
	elif [ "$de" == "lxde" ]; then
		pcmanfm --set-wallpaper="$picdir/$var"
	elif [ "$de" == "cinnamon" ]; then
		gsettings set org.cinnamon.desktop.background picture-uri "file:///$picdir/$var"
	elif [ "$de" == "wmfeh" ]; then
		feh --bg-fill "$picdir/$var"
	elif [ "$de" == "macos" ]; then
		osascript -e 'tell application "Finder" to set desktop picture to POSIX file "'"$picdir/$var"'"'
	fi
}

fetchAbstract() {
	var=`curl https://vlepy.github.io/feed.xml | grep abstract | grep -v scaled_ | grep jpg | awk -F ";" '{print $3}' | awk -F "&" '{print $1}' | tail -n 1 | awk -F "/" '{print $(NF)}'`
	curl -o $var `curl https://vlepy.github.io/feed.xml | grep abstract | grep -v scaled_ | grep jpg | awk -F ";" '{print $3}' | awk -F "&" '{print $1}' | tail -n 1`
	md5sum_1=`md5sum $var | awk '{print $1}'`
	echo "abstract fethed"
}

cd $picdir

while [ 1 ]; do

	if [ "$wallpaperset" != "1" ]; then
		sleep 10s
		fetchAbstract
		setWallpaper
		wallpaperset=1
	fi
	
	sleep 1h
	
	curl -o temp.jpg `curl https://vlepy.github.io/feed.xml | grep abstract | grep -v scaled_ | grep jpg | awk -F ";" '{print $3}' | awk -F "&" '{print $1}' | tail -n 1`
	md5sum_2=`md5sum temp.jpg | awk '{print $1}'`
	if [ "$md5sum_1" == "$md5sum_2" ]; then
		echo "No new abstracts."
		rm temp.jpg
	else
		fetchAbstract
		setWallpaper
		rm temp.jpg
	fi
done

