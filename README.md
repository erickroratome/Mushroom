Our project consists of ransomware analysis software using honeyfiles.

Installation Instructions:

In your Linux terminal, download the necessary files using git clone:

~$ git clone https://github.com/erickroratome/Mushroom.git

If git is not installed:

~$ sudo apt install git

After installing, give execute permission to the "instalador.sh" script:

~$ sudo chmod +x ./Mushroom/instalador.sh

Run the installer with privileges:

~$ sudo ./Mushroom/instalador.sh

When the installation is complete, restart the machine to start the processes.

Our solution performs a backup of the user's files when the machine is initialized, which are stored in /backup. If you want to disable automatic backups:

~$ sudo systemctl disable backup

NOTE:
We have provided a folder with some famous ransomware samples on the market to test the solution (NOTE: I advise testing only in VMs!).

To avoid problems, the .zip file is password-protected with the password: "infected."

If you want to extract it via the terminal:
~# unzip -p infected ./Mushroom/RANSOMWARE
or
~# 7z x ./Mushroom/RANSOMWARE.zip -pinfected

To install 7zip:
~# sudo apt install p7zip-full
