#!/bin/basH
# ackeack's workenv config

grep "CentOS" /etc/redhat-release
isCentOS=$?
grep "Ubuntu" /etc/lsb-release
isUbuntu=$?

if [ $isCentOS -eq "0" ]; then
    echo 'SYS: yum install CentOS related devel packages'
    if [ $USER = "root" ]; then
        yum install -y screen zsh
    else
        echo 'WARNING:The user has no privileges to install yum packages'
    fi
elif [ $isUbuntu -eq "0" ]; then
    echo 'SYS: apt-get Ubuntu install env packages'
    sudo apt-get install screen zsh
fi

git submodule init env/oh-my-zsh
git submodule update env/oh-my-zsh

#install screenrc
cp -f env/.screenrc $HOME/.screenrc

# install zsh with oh-my-zsh
rm -rf $HOME/.oh-my-zsh
cp -rf env/oh-my-zsh $HOME/.oh-my-zsh
cp -f env/.zshrc $HOME/.zshrc

chsh -s /bin/zsh
exec zsh
