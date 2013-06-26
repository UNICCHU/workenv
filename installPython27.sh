#!/bin/env bash

grep "CentOS" /etc/redhat-release
isCentOS=$?
grep "Ubuntu" /etc/lsb-release
isUbuntu=$?

if [ $isCentOS -eq "0" ]; then
    echo 'SYS: yum install CentOS related python packages'
    yum install -y python python-setuptools gcc zlib-devel openssl openssl-devel mysql-devel
elif [ $isUbuntu -eq "0" ]; then
    echo 'SYS: apt-get Ubuntu install related python packages'
    sudo apt-get install gcc build-essential zlib1g-dev python python-setuptools libssl-dev openssl-dev mysql-dev
fi

#
easy_install pythonbrew
pythonbrew_install

grep 'Pythonbrew' $HOME/.bashrc
if [ $? -ne 0 ]; then
    echo "# Pythonbrew setting " >> $HOME/.bashrc
    echo "[[ -s \"\$HOME/.pythonbrew/etc/bashrc\" ]] && source \"\$HOME/.pythonbrew/etc/bashrc\" " >> $HOME/.bashrc
fi
source ~/.bashrc

pythonbrew install Python 2.7.3
pythonbrew switch 2.7.3

easy_install pycrypto
easy_install nose
easy_install mysql-connector-python
easy_install paramiko
easy_install unittest-xml-reporting
easy_install ipython
