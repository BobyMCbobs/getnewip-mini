#!/bin/bash

# getnewip-mini

#
# Copyright (C) 2018 Caleb Woodbine <github.com/BobyMCbobs>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#

# User variables
dropboxFolder=""
pingServer=""
gniUnit=""
dropboxAppKey=""
curlTimeoutTime=3

echo "WELCOME to getnewip-mini.sh
==========================="

function IPfromDB() {
# download current IP from dropbox

echo "> Downloading copy of IP from dropbox."
tmpFile=".getnewip-response-$RANDOM-temp"
newIPnum=$(curl -m $curlTimeoutTime --progress-bar -X POST --globoff -D "$tmpFile" --header "Authorization: Bearer $dropboxAppKey" --header "Dropbox-API-Arg: {\"path\": \"/$dropboxFolder/currentip-$gniUnit.txt\"}" "https://content.dropboxapi.com/2/files/download")
checkHttpResponse || exit 1

if [[ $newIPnum =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]
then
	echo "> Downloaded IP successfully."
	[[ -f $tmpFile ]] && rm $tmpFile
	return 0
else
	echo ">> Download Failed."
	echo "> Check '$tmpFile' for info."
	exit 1
fi

}

function checkHttpResponse() {
# verify if response was successful

local response
response=$?

if [ ! $response = 0 ]
then
	echo ">> Failed to access dropbox in some way." && return 1
fi

return 0

}

if [[ -z $dropboxFolder || -z $pingServer || -z $gniUnit || -z $dropboxAppKey || -z $curlTimeoutTime ]]
then
	echo ">> Variables not set! Edit this program's variables section then rerun."
	exit 1

elif [ ! "${#dropboxAppKey}" = 64 ]
then
	echo ">> Dropbox app key is invalid."
	exit 1

elif [[ ! $pingServer =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]
then
	echo ">> Ping server must be a vaild IPv4 address."
	exit 1

elif [[ ! $curlTimeoutTime = [0-9] ]]
then
	echo ">> Curl timeout must be vaild"
	exit 1

fi

#check for required packages
if ! which curl > /dev/null || ! which stat > /dev/null
then
	echo "> Missing packages 'coreutils' and/or 'curl'."
fi

#test for internet connection
if ping -q -c 1 -W 1 $pingServer > /dev/null
then
	echo "> Internet is connected, continuing."
else
	echo ">> No internet, exiting."
	exit 1
fi

IPfromDB

#output it
echo "
==============
Current IP is '$newIPnum'.
=============="
