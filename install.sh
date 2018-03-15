#!/bin/bash

# Installation script for dotfiles
##################################


# functions
function link_file_to_home {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    ln -sf ${source} ${target}
}


# List of Applications to be installed
PACKAGES='git zsh screen python-pip tree'

# Install applications listed above
if [ -f /etc/redhat-release ]; then 
    sudo yum update -y 
    sudo yum install -y $PACKAGES
    
    if [ ! -f $(which vim) ]; then
        sudo yum install -y vim
    fi

    # Visual Studio Code
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    yum check-update
    sudo yum install -y code

    # Virtual Box
    #sudo rpm --import oracle_vbox.asc
    #wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | rpm --import -
    sudo yum install -y VirtualBox-5.2


elif [ -f /etc/lsb-release ]; then 
    sudo add-apt-repository ppa:shutter/ppa
    sudo apt-get update 
    sudo apt-get install -y $PACKAGES
    sudo apt-get install -y vim-nox
    sudo apt-get install -y shutter
    sudo apt-get install -y virtualbox-5.2

    # Visual Studio Code
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt-get update
    sudo apt-get install code # or code-insiders

else
    echo "ERROR - Release file not found"
    echo "ERROR - Can not determine package management"
    echo "INFO - Exit instalation script"
    exit
fi

# Vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Clone repo
git clone https://github.com/agpinto/dotfiles ~/.dotfiles

# Initialize submodules
cd ~/.dotfiles
git submodule update --init --recursive

# Link files
for i in _*
    do
    link_file_to_home $i
    done

# AWS
sudo pip install awscli

# Ansible
sudo pip install ansible

# Virtual Environments
sudo pip install virtualenv

# Python libraries:
#  - Boto3
sudo pip install boto3

#  - Docopt
sudo pip install docopt==0.6.2

#  - Requests
sudo pip install requests

# Make ZSH the default shell
sudo chsh -s $(which zsh)
