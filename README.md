Certainly, here are the installation instructions without the bash prompts:

**Our project consists of ransomware analysis software using honeyfiles.**

**Installation instructions:**

**Dependencies:**
  - Linux (Preferably Debian-based)
  - auditd
  - inotify-tools
  - wget
  - zip
  - git

**Download the necessary files with git clone:**
```shell
git clone https://github.com/erickroratome/Mushroom.git
```

**If git is not installed:**
```shell
sudo apt install git
```

**After installing, grant execution permission to the "instalador.sh" file:**
```shell
sudo chmod +x ./Mushroom/instalador.sh
```

**Run the installer with privileges:**
```shell
cd ./Mushroom
sudo ./instalador.sh
```

**Once the installation is complete, restart the machine to start the processes.**

**Our solution backs up user files upon machine startup, which are stored in /backup. If you want to disable automatic backups:**
```shell
sudo systemctl disable backup
```

**Note:**
We've provided a folder with some famous ransomware samples in the market to test the solution (Note: I advise testing only in VMs!).

**To avoid problems, the .zip file is password-protected with "infected" as the password.**

**If you want to extract it via the terminal:**
```shell
unzip -p infected ./Mushroom/RANSOMWARE.zip
```
or
```shell
7z x ./Mushroom/RANSOMWARE.zip -pinfected
```

**To install 7zip:**
```shell
sudo apt install p7zip-full
```
