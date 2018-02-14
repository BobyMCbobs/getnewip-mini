# getnewip-mini

This is a mini version of github.com/BobyMCbobs/getnewip, intended for use on devices such as Android phones, where you can't update ssh config.
This program will download the currentip file from a select dropbox folder and cat it into the shell.

This program was made to work with Termux for Android (termux.com, f-droid.org/en/packages/com.termux).
If this program doesn't match your use case, try getnewip (standard).

Using:
  Install Termux from the F-droid store. 
  Copy getnewip-mini.sh to the sdcard or other storage. 
  Run (something like) 'cp /sdcard/getnewip-mini.sh .'.
  Then to install and run, run 'bash getnewip-mini.sh'.

NOTE: 
  - Everytime this is run, it will download the IP and cat it, regardless of it's changed.
  - Please change the variables in the beginning of getnewip-mini to make it how it should be for your setup.
  - This will install required packages, so no need to worry about that.
  - Your dropbox app's OAuth2 access token will need to go into the variable 'dropboxkey' inside the program.
    - You must create a Dropbox app over at https://www.dropbox.com/developers/apps, then click generate OAuth2 access token.

Idea for usage:
  Create a .profile in termux's home directory and put something like 'bash getnewip-mini-sh' into it, to run this everytime it is launched.

This project is under GPL3, feel free to use it according to the license as you please.
