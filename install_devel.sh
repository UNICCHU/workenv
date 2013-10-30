#!/bin/env bash


YUM_PACKAGES=" python python-setuptools gcc zlib-devel openssl openssl-devel mysql-devel readline readline-devel readline-static openssl-static sqlite-devel bzip2-devel bzip2-libs"
echo $YUM_PACKAGES
DPKG_PACKAGES=" gcc build-essential zlib1g-dev python python-setuptools libssl-dev openssl-dev mysql-dev "

INSTALL_PYTHON="2.7.5"
PYTHON_PACKAGES="virtualenv ipython "

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
    echo 'SYS: apt-get Ubuntu install related python packages'
    sudo apt-get install $DPKG_PACKAGES
fi

git submodule init devel/pyenv
git submodule update devel/pyenv
rm -rf $HOME/.pyenv
cp -rf devel/pyenv $HOME/.pyenv

grep "## workenv: devel ##" $HOME/.bashrc
if [ $? -ne "0" ]; then
    echo '## workenv: devel ##' >> $HOME/.bashrc
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.bashrc
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.bashrc
    echo 'eval "$(pyenv init -)"' >> $HOME/.bashrc
    source $HOME/.bashrc
fi

if [ -f $HOME/.zshrc ]; then
    grep "## workenv: devel ##" $HOME/.zshrc
    if [ $? -ne "0" ]; then
        echo "## workenv: devel ##" >> $HOME/.zshrc
        echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.zshrc
        echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.zshrc
        echo 'eval "$(pyenv init -)"' >> $HOME/.zshrc
        source $HOME/.zshrc
    fi
fi

pyenv install $INSTALL_PYTHON
pyenv global $INSTALL_PYTHON
pyenv versions

pip install $PYTHON_PACKAGES

echo 'SYS: install devel-packages successfully'
exit 0
