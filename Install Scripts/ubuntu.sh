#!/bin/bash
#
# Note: Script assumes running as root (i.e. sudo not required)
#

#
# System prep - update & upgrade packages, enable case-insensite tab completion,
# cd to system root for known starting location, download & install basic utilities
#
clear
cd /
echo -e -n "\n\v\033[1;36m--------------------\n\033[1;33m      Apt Update\033[1;36m\n--------------------\033[0m\n"\
	&& apt update && echo -e -n "\n\v\033[1;36m--------------------\n\033[1;33m    Apt Upgrade\033[1;36m\n--------------------\033[0m\n" && apt upgrade -y && apt dist-upgrade -y && apt autoremove && apt --fix-broken install\
	&& echo -e -n "\n\v\033[1;36m--------------------\n\033[1;33m    Snap Refresh\033[1;36m\n--------------------\033[0m\n" && snap refresh && echo -e -n "\n\v"
echo 'set completion-ignore-case On' >> /etc/inputrc
echo -e -n "\n\v\033[1;36m---------------------\n\033[1;33m Installing Utilities\033[1;36m\n---------------------\033[0m\n"
apt install -y git gh curl neofetch htop lolcat php-zip net-tools nano

#
# Install Starship prompt & JetBrainsMono Nerd Font package
#
echo -e -n "\n\v\033[1;36m--------------------\n\033[1;33m Installing Starship\033[1;36m\n--------------------\033[0m\n"
git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts
cd nerd-fonts && git sparse-checkout add patched-fonts/JetBrainsMono
mkdir -p /usr/share/fonts/nerdfonts && mv -v /nerd-fonts/* /usr/share/fonts/nerdfonts/
cd / && rm -rf nerd-fonts

curl -sS https://starship.rs/install.sh | sh

#
# Create & configure SysAdmin account
#
echo -e -n "\n\v\033[1;36m--------------------\n\033[1;33m Creating Admin User\033[1;36m\n--------------------\033[0m\n"
useradd -m -U -s /bin/bash -p "saWKjq.ZH/kSA" admin

#
# Download Bash & Starship config files
#
echo -e -n "\n\v\033[1;36m--------------------\n\033[1;33m Downloading Configs\033[1;36m\n--------------------\033[0m\n"
cd /etc && mv bash.bashrc bash.bashrc.BAK
curl -fLo bash.bashrc https://raw.githubusercontent.com/zmhiller/init/main/Bash/bash.bashrc
curl -fLo bash.bash_aliases https://raw.githubusercontent.com/zmhiller/init/main/Bash/bash.bash_aliases

cd /home/admin
mv .bashrc .bashrc.BAK && curl -fLo .bashrc https://raw.githubusercontent.com/zmhiller/init/main/Bash/.bashrc
curl -fLo .bash_aliases https://raw.githubusercontent.com/zmhiller/init/main/Bash/.bash_aliases
mkdir .config && cd /.config
curl -fLo starship.toml https://raw.githubusercontent.com/zmhiller/init/main/Starship/starship.toml

echo -e -n "\n\v\033[1;36m--------------------\n\033[1;33m      Finishing\033[1;36m\n--------------------\033[0m\n"

login admin