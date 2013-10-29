#!/bin/env bash

grep "CentOS" /etc/redhat-release
isCentOS=$?
grep "Ubuntu" /etc/lsb-release
isUbuntu=$?

if [ $isCentOS -eq "0" ]; then
    echo 'SYS: yum install CentOS env packages'
    yum install -y screen zsh
elif [ $isUbuntu -eq "0" ]; then
    echo 'SYS: apt-get Ubuntu install env packages'
    sudo apt-get install screen zsh
fi

# install zsh with oh-my-zsh
chsh -s /bin/zsh
#

