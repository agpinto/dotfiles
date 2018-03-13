#!/bin/bash

#####################
#
# Installation script for dotfiles
#
#####################


# functions
function link_file_to_home {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    ln -sf ${source} ${target}
}


# List of Applications to be installed
PACKAGES='git zsh screen vim-nox python-pip tree'

# Install applications listed above
if [ -f /etc/redhat-release ]; then 
    sudo yum update -y && sudo yum install -y $PACKAGES
elif [ -f /etc/lsb-release ]; then 
    sudo apt-get update && sudo apt-get install -y $PACKAGES
else
    echo "ERROR - Release file not found"
    echo "ERROR - Can not determine package management"
    echo "INFO - Exit instalation script"
    exit

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

# Make ZSH the default shell
chsh -s $(which zsh)

# AWS
sudo pip install awscli

# Ansible
sudo pip install ansible
