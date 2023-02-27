#!/bin/bash
#
# Note: Script assumes running as root (i.e. sudo not required)
#

#
# System prep - update & upgrade packages, enable case-insensite tab completion,
# cd to system root for known starting location, download & install basic utilities
#
cd /
apt update
apt upgrade -y
apt dist-upgrade -y
apt --fix-broken install
apt autoremove
echo 'set completion-ignore-case On' >> /etc/inputrc
apt install -y git gh curl neofetch htop lolcat php-zip net-tools nano

#
# Install Starship prompt & JetBrainsMono Nerd Font package)
#
git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts
cd nerd-fonts && git sparse-checkout add patched-fonts/JetBrainsMono
mkdir -p /usr/share/fonts/nerdfonts && mv -v /nerd-fonts/* /usr/share/fonts/nerdfonts/
cd / && rm -rf nerd-fonts

curl -sS https://starship.rs/install.sh | sh

#
# Download Bash & Starship config files
#
cd /etc && mv bash.bashrc bash.bashrc.BAK
curl -fLo bash.bashrc https://raw.githubusercontent.com/zmhiller/init/main/Bash/bash.bashrc
curl -fLo bash.bash_aliases https://raw.githubusercontent.com/zmhiller/init/main/Bash/bash.bash_aliases

cd /home
curl -fLo .bashrc https://raw.githubusercontent.com/zmhiller/init/main/Bash/.bashrc
curl -fLo .bash_aliases https://raw.githubusercontent.com/zmhiller/init/main/Bash/.bash_aliases
curl -fLo starship.toml https://raw.githubusercontent.com/zmhiller/init/main/Starship/starship.toml

