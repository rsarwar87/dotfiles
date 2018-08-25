#!/bin/bash

nargs=$#

DATE=$("%d%m%Y")
N=1

# Increment $N as long as a directory with that name exists
while [[ -d "backup-$DATE-$N" ]] ; do
    N=$(($N+1))
done
mkdir "backup-$DATE-$N"
BDIR=backup-$DATE-$N

#
# disable post installation interactive menus - note: packages will install default configs
#
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
curl -L https://get.oh-my.fish | fish

#
# copy configuration files and ccfe utilities
#
 
 #backup
 cp ~/.config/nvim/init.vim $BDIR/. -rv
 cp ~/.config/fish/config.fish $BDIR/. -rv
 cp ~/.config/tmux/.tmux.conf* $BDIR/. -rv
 #tmux neovim
 
 cp .config/* ~/.config/ -rv
 cp .config/nvim/init2.vim ~/.config/nvim/init.vim -rv
 mkdir -p ~/.local/share/nvim/plugged
 cp .tmux* ~/. -rv
 # vimrc
 echo "\"set g:go_version_warning = 0" >> ~/.vimrc
 echo "set number" >> ~/.vimrc
 echo "\"syntax on" >> ~/.vimrc
 # base/input for sunOS and color scheme for sunOS
 cp ~/.bash* $BDIR/. -rv
 cp ~/.inputrc* $BDIR/. -rv
 cp ~/.Xres* $BDIR/ -rv.
 cp .bash* ~/ -rv.
 cp .inputrc ~/. -rv
 cp .Xres* ~/. -rv

 #get vimrc #### https://github.com/amix/vimrc
 git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
 sh ~/.vim_runtime/install_awesome_vimrc.sh
 mkdir ~/bin

 #install neovim plugins
 #nvim +PluginInstall +qall
 nvim -E -c PlugInstall -c q 
 ~/.local/share/nvim/plugged/YouCompleteMe/install.py

#
# CCFE stuff
#
 cp packages/usr/bin/gimme ~/bin/.
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

    cp -rv /etc/cups/cups-browsed.conf $BDIR/.
    cp -rv /etc/ntp.conf $BDIR/.
    cp -rv /etc/systemd/timesyncd.conf $BDIR/.
    cp -rv /etc/security/pam_mount.conf.xml $BDIR/.

    cp -rv ./packages/etc/cups/cups-browsed.conf /etc/cups/.
    cp -rv  packages/etc/ntp.conf /etc/ntp.conf
    cp -rv  packages/etc/systemd/timesyncd.conf /etc/systemd/
    cp -rv packages/etc/security/pam_mount.conf.xml /etc/security/.


    # restart services with modified configurations
    service ntp restart
    service cups restart
 fi
