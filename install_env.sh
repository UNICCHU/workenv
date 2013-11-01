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

# install screenrc
if [ -f $HOME/.screenrc ]; then
    mv $HOME/.screenrc $HOME/.screenrc_bak
fi
cp -f env/.screenrc $HOME/.screenrc

# install zsh
if [ ! -d env/oh-my-zsh ]; then
    echo 'ERROR: make sure to execute update_module.sh first'
    exit -1
fi
if [ -d $HOME/.oh-my-zsh ]; then
    rm -rf $HOME/.oh-my-zsh_bak
    mv $HOME/.oh-my-zsh $HOME/.oh-my-zsh_bak
fi

if [ -f $HOME/.zshrc ]; then
    mv $HOME/.zshrc $HOME/.zshrc_bak
fi

cp -rf env/oh-my-zsh $HOME/.oh-my-zsh
cp -f env/.zshrc $HOME/.zshrc

chsh -s /bin/zsh
echo 'SYS: install env-packages successfully'
