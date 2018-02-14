#!/bin/bash

#variables
getnewipfolder="$HOME/.getnewip-mini"
tmpfolder="$HOME/tmp"
dropboxfolder=""
pingserver="8.8.8.8"
purpose=""
dropboxkey=""
#

echo "WELCOME to getnewip-mini.
=============="

if [ $getnewipfolder="" ] || [ $tmpfolder="" ] || [ $dropboxfolder="" ] || [ $pingserver="" ] || [ $purpose="" ] || [ $dropboxkey="" ]
then
	echo "> Variables not set! Edit this program's variables section then rerun."
	exit
fi

#check for required packages
if ! which curl > /dev/null || ! which stat > /dev/null
then
	echo "> Missing packages, installing."
	apt install coreutils curl -y
fi

#test for internet connection
if ping -q -c 1 -W 1 $pingserver > /dev/null
then
	echo "> Internet is connected, continuing."
else
	echo "> No internet, exiting."
	exit
fi

#if getnewipfolder doesn't exist, create it
if [ ! -d $getnewipfolder ]
then
	echo "> Making bin folder."
	mkdir -p $getnewipfolder
fi

#if tmp folder doesn't exist, create it
if [ ! -d $tmpfolder ]
then
	echo "> Making tmp folder."
	mkdir -p $tmpfolder
fi

if [ ! -f $HOME/.dropbox_uploader ]
then

	if echo "OAUTH_ACCESS_TOKEN=$dropboxkey" > $HOME/.dropbox_uploader
		then
			echo "> DropBox Uploader config made."
	fi
fi

#if dropbox_uploader hasn't been downloaded, download it, and change tmp folder
if [ ! -f $getnewipfolder/dropbox_uploader.sh ]
then
	echo "> Downloading dropbox uploader."
	if curl "https://raw.githubusercontent.com/andreafabrizi/Dropbox-Uploader/master/dropbox_uploader.sh" -o $getnewipfolder/dropbox_uploader.sh > /dev/null
	then
		echo "> Download Complete."
		chmod +x $getnewipfolder/dropbox_uploader.sh
		if sed -i "35s#/tmp#$tmpfolder#g" $getnewipfolder/dropbox_uploader.sh
		then
			echo "> Modified '$getnewipfolder/dropbox_uploader.sh' with new tmp directory"
		else
			echo "> Failed updating '$getnewipfolder/dropbox_uploader.sh' with new tmp directory."
			exit
		fi
	else
		echo "> Download Failed."
		exit
	fi
fi

#if there is a currentip-*.txt file, remove it
if [ -f currentip-$purpose.txt ]
then
	rm currentip-$purpose.txt
fi

#download ip into correct folder and check that it's downloaded it
if cd $getnewipfolder && bash $getnewipfolder/dropbox_uploader.sh download /$dropboxfolder/currentip-$purpose.txt && [ -f currentip-$purpose.txt ]
then
	echo "Download Complete."
else
	echo "Download Failed."
	exit
fi

#output it
echo "
==============
Current IP is '$(cat currentip-$purpose.txt)'.
=============="
