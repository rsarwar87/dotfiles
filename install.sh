#!/bin/bash

nargs=$#
#
# disable post installation interactive menus - note: packages will install default configs
 export DEBIAN_FRONTEND=noninteractive

# update, upgrade and install required packages

 if [ -f /etc/redhat-release  ]; then
      yum update
      yum -y install epel-release
      curl -o /etc/yum.repos.d/dperson-neovim-epel-7.repo https://copr.fedorainfracloud.org/coprs/dperson/neovim/repo/epel-7/dperson-neovim-epel-7.repo
      yum -y install neovim

      #get yum packages
      #apt install git ntp xtightvncviewer ssh cifs-utils iftop iotop htop libpam-mount python3 python3-requests tmux neovim python3-pip python-pip -y
 fi

 if [ -f /etc/lsb-release  ]; then
    apt-add-repository ppa:fish-shell/release-2 -y
    add-apt-repository ppa:neovim-ppa/unstable -y

    apt update
    apt upgrade -y
    apt install git ntp xtightvncviewer ssh cifs-utils iftop iotop htop libpam-mount python3 python3-requests tmux neovim python3-pip python-pip fonts-powerline wmctrl python python-numpy python-setuptools  -y
 fi


#
# copy configuration files and ccfe utilities
#
 #tmux neovim
 cp .config/* ~/.config/ -rv
 mkdir -p ~/.local/share/nvim/plugged
 cp .tmux* ~/.
 # vimrc
 echo "\"set g:go_version_warning = 0" >> ~/.vimrc
 echo "set number" >> ~/.vimrc
 echo "\"syntax on" >> ~/.vimrc
 # base/input for sunOS and color scheme for sunOS
 cp .bash* ~/.
 cp .inputrc ~/.
 cp .Xres* ~/.


 mkdir ~/bin
 cp packages/usr/bin/gimme ~/bin/.
 nvim +PluginInstall +qall
 #nvim -E -c PlugInstall -c q
 ~/.local/share/nvim/plugged/YouCompleteMe/install.py

# create mount point for CCFE shares mounted by pam_mount
if [ $nargs -ge 1  ]; then
    git submodule update --init -- packages
    if [[ ! -e  /network ]]; then
        mkdir /network
        chmod 755 /network
    else
        echo "/network already exists; skipping..."
    fi

    # print servers
    cp -rv packages/etc/cups/* /etc/cups/
    cp -v  packages/etc/ntp.conf /etc/ntp.conf
    cp -v  packages/etc/systemd/timesyncd.conf /etc/systemd/
    cp -rv packages/etc/security/pam_mount.conf.xml /etc/security/.


    # restart services with modified configurations
    service ntp restart
    service cups restart
fi
