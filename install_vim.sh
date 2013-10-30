#!/bin/bash
# ackack's workenv 

function func_execute_and_check() {
    echo 'INFO: Process' $1'...'
    $1
    if [ $? -ne 0 ]; then
        echo 'ERROR: Operation failed:' $1
	exit 1
    fi
}

func_execute_and_check 'source cmds/submod_sync.sh'
func_execute_and_check 'source cmds/submod_upgrade.sh'
mv -rf $HOME/.vim $HOME/.vim_bak
mv -rf $HOME/.vimrc $HOME/.vimrc_bak
cp -rf vim/.vim $HOME
cp -rf vim/.vimrc $HOME
echo 'SYS: install vim successfully'
