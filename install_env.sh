#!/bin/env bash
# ackeack's workenv config


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

git submodule init env/oh-my-zsh
git submodule update env/oh-my-zsh

#install screenrc
cp -f env/.screenrc $HOME/.screenrc

# install zsh with oh-my-zsh
cp -rf env/oh-my-zsh $HOME/.oh-my-zsh
cp -f env/.zshrc $HOME/.zshrc

grep "exec /bin/zsh --login" $HOME/.bashrc
if [ $? -ne "0" ]; then
    echo "## workenv: execute zsh ##" >> $HOME/.bashrc
    echo "exec /bin/zsh --login" >> $HOME/.bashrc
    exec /bin/zsh --login
fi

