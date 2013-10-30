#!/bin/env bash


YUM_PACKAGES=" python python-setuptools gcc zlib-devel openssl openssl-devel mysql-devel readline readline-devel readline-static openssl-static sqlite-devel bzip2-devel bzip2-libs"
DPKG_PACKAGES=" gcc build-essential zlib1g-dev python python-setuptools libssl-dev openssl-dev mysql-dev "

INSTALL_PYTHON="2.7.5"
PYTHON_PACKAGES="ipython virtualenv virtualenvwrapper nose"

grep "CentOS" /etc/redhat-release
isCentOS=$?
grep "Ubuntu" /etc/lsb-release
isUbuntu=$?

if [ $isCentOS -eq "0" ]; then
    echo 'SYS: yum install CentOS related devel packages'
    if [ $USER = "root" ]; then
        yum install -y $YUM_PACKAGES
    else 
        echo 'WARNING:The user has no privileges to install yum packages'
    fi
elif [ $isUbuntu -eq "0" ]; then
    echo 'SYS: apt-get install Ubuntu related python packages'
    sudo apt-get install $DPKG_PACKAGES
fi

git submodule init devel/pyenv
git submodule update devel/pyenv
if [ ! -d $HOME/.pyenv ]; then
    echo 'INFO: installing pyenv '
    cp -rf devel/pyenv $HOME/.pyenv
fi

#### Setting .pyenv PATH ####
export PATH=$HOME/.pyenv/bin:$PATH
eval "$(pyenv init -)"

#### Install specific python packages ####
pyenv install $INSTALL_PYTHON
pyenv global $INSTALL_PYTHON
pyenv versions

pip install $PYTHON_PACKAGES

#### Configure for virtualenv ####
export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

#### write configuration files ####
grep "## workenv: devel ##" $HOME/.bashrc
if [ $? -ne "0" ]; then
    echo '## workenv: devel ##' >> $HOME/.bashrc
    echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> $HOME/.bashrc
    echo 'eval "$(pyenv init -)"' >> $HOME/.bashrc
    echo 'export WORKON_HOME=$HOME/.virtualenvs' >> $HOME/.bashrc
    echo 'source /usr/bin/virtualenvwrapper.sh' >> $HOME/.bashrc
fi

if [ -f $HOME/.zshrc ]; then
    grep "## workenv: devel ##" $HOME/.zshrc
    if [ $? -ne "0" ]; then
        echo "## workenv: devel ##" >> $HOME/.zshrc
        echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> $HOME/.zshrc
        echo 'eval "$(pyenv init -)"' >> $HOME/.zshrc
        echo 'export WORKON_HOME=$HOME/.virtualenvs' >> $HOME/.zshrc
        echo 'source /usr/bin/virtualenvwrapper.sh' >> $HOME/.zshrc
    fi
fi

echo 'SYS: install devel-packages successfully'
