# Custom alias file

alias i='apt install'
alias si='snap install'
alias update='apt update'
alias refresh='snap refresh'
alias upgrade='echo -e -n "\n\v\033[1;36m--------------------\n\033[1;33m      Apt Update\033[1;36m\n--------------------\033[0m\n"\
	&& apt update && echo -e -n "\n\v\033[1;36m--------------------\n\033[1;33m    Apt Upgrade\033[1;36m\n--------------------\033[0m\n" && apt upgrade -y\
	&& echo -e -n "\n\v\033[1;36m--------------------\n\033[1;33m    Snap Refresh\033[1;36m\n--------------------\033[0m\n" && snap refresh && echo -e -n "\n\v"'
alias upgradea='apt upgrade -y'
alias upgrades='snap refresh'
alias upgradekb='apt --with-new-pkgs upgrade -y'
alias fupgrade='apt full-upgrade'
alias purge='apt purge'
alias remove='snap remove'
alias nano='nano -c'
alias cat='lolcat'
alias nms='nms -a -f green -s *'
alias python='python3'
alias bindec='python3 /usr/local/bin/bindec.py'
