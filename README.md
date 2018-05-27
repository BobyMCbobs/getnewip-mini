# getnewip-mini

This is a mini version of [getnewip](https://github.com/BobyMCbobs/getnewip), intended for use on devices such as Android phones, where you don't update ssh config.
This program will download the currentip file from a select dropbox folder and cat it into the shell.
This program was designed to work with [Termux](http://termux.com) for Android, although there is absolutely no reason why it won't work else where.
Get Termux on [F-Droid](http://f-droid.org/en/packages/com.termux).

##### Installation
Method #1
1. Install Termux from the F-droid store. 
2. Run '`pkg i git`' inside Termux to install git.
3. '`git clone https://github.com/BobyMCbobs/getnewip-mini.git`'

Method #2
1. Clone this repo.
2. Copy getnewip-mini.sh to the SD card/storage of the Android phone.
3. `mv /sdcard/getnewip-mini.sh .` to move the script inside of Termux.

##### Run time dependencies
- coreutils
- curl

##### Setup
Fill in the empty variables at the start of getnewip-mini.sh

##### Usage
'`bash getnewip-mini`'

##### Notes
This version of getnewip simply prints the IP address from a given server configured out.

##### Dropbox app
1. Go to [Dropbox app](https://www.dropbox.com/developers/apps) page.      
2. Choose 'Dropbox API', 'App Folder', finally give it a unique name.      
3. Under 'OAuth2' find 'Generate access token'. Use the string of characters returned in variable 'dropboxAppKey' for a unit config file.  

##### Idea for usage
Create a .profile in termux's home directory and put something like '`bash getnewip-mini-sh`' into it, to run this everytime it is launched.
