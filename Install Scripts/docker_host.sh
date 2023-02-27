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
apt install -y git gh curl neofetch htop lolcat php-zip net-tools nano mlocate

#
# Install Starship prompt & JetBrainsMono Nerd Font package
#
#echo -e -n "\n\v\033[1;36m--------------------\n\033[1;33m Installing Starship\033[1;36m\n--------------------\033[0m\n"
#git clone --filter=blob:none --sparse https://github.com/ryanoasis/nerd-fonts
#cd nerd-fonts && git sparse-checkout add patched-fonts/JetBrainsMono && ./install.sh
#cd / && rm -rf nerd-fonts
#
#curl -sS https://starship.rs/install.sh | sh

#
# Create & configure SysAdmin accounts
#
echo -e -n "\n\v\033[1;36m--------------------\n\033[1;33m Creating Admin User\033[1;36m\n--------------------\033[0m\n"
useradd -m -U -s /bin/bash -p "saWKjq.ZH/kSA" admin
usermod -aG sudo admin

#
# Download Bash & Starship config files
#
echo -e -n "\n\v\033[1;36m--------------------\n\033[1;33m Downloading Configs\033[1;36m\n--------------------\033[0m\n"
cd /etc && mv bash.bashrc bash.bashrc.BAK
curl -fLo bash.bashrc https://raw.githubusercontent.com/zmhiller/init/main/Bash/bash.bashrc
curl -fLo bash.bash_aliases https://raw.githubusercontent.com/zmhiller/init/main/Bash/bash.bash_aliases

cd /root
mv .bashrc .bashrc.BAK && curl -fLo .bashrc https://raw.githubusercontent.com/zmhiller/init/main/Bash/.bashrc
cd /home/admin && mv .basrc .bashrc.BAK && cp /root/.bashrc .bashrc
curl -fLo .bash_aliases https://raw.githubusercontent.com/zmhiller/init/main/Bash/.bash_aliases
#mkdir .config && cd .config
#curl -fLo starship.toml https://raw.githubusercontent.com/zmhiller/init/main/Starship/starship.toml
#chown -R admin /home/admin && chgrp -R admin /home/admin
#chmod -R 744 /home/admin

echo -e -n "\n\v\033[1;36m--------------------\n\033[1;33m  Installing Docker\n   Enter Password\n      then exit\033[1;36m\n--------------------\033[0m\n"
login admin
sudo apt remove docker docker-engine docker.io containerd runc
sudo apt install -y ca-certificates gnupg lsb-release
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker admin

echo -e -n "\n\v\033[1;36m---------------------\n\033[1;33mConfiguring Portainer\033[1;36m\n---------------------\033[0m\n"
mkdir -p /docker/containers && cd /docker/containers
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
docker run -d \
  -p 9001:9001 \
  --name portainer_agent \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/docker/volumes:/var/lib/docker/volumes \
  portainer/agent:2.17.0


echo -e -n "\n\v\033[1;36m--------------------\n\033[1;33mFinishing.... Login:\033[1;36m\n--------------------\033[0m\n"

login admin
