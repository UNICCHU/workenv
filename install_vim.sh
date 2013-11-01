#!/bin/bash
# ackack's workenv 

if [ ! -d vim/.vim ]; then
    echo 'ERROR: make sure to execute update_module.sh first'
    exit -1
fi

if [ -f $HOME/.vimrc ]; then
    mv -f $HOME/.vimrc $HOME/.vimrc_bak
fi
if [ -d $HOME/.vim ]; then
    rm -rf $HOME/.vim_bak
    mv -f $HOME/.vim $HOME/.vim_bak
fi
cp -rf vim/.vim $HOME
cp -rf vim/.vimrc $HOME
echo 'SYS: install vim successfully'
