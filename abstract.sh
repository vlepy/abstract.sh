#!/bin/bash
picdir=$HOME/Obrazy
cd $picdir
var=`curl 2>&1 /dev/null https://vlepy.github.io/feed.xml | grep abstract | grep -v scaled_ | grep png | awk -F ";" '{print $3}' | awk -F "&" '{print $1}' | tail -n 1 | awk -F "/" '{print $(NF)}'`
wget `curl 2>&1 /dev/null https://vlepy.github.io/feed.xml | grep abstract | grep -v scaled_ | grep png | awk -F ";" '{print $3}' | awk -F "&" '{print $1}' | tail -n 1`
gsettings set org.gnome.desktop.background picture-uri file:///$picdir/$var
echo $var
echo $picdir

