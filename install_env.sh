#!/bin/basH
# ackeack's workenv config

OS="none"

function detect_os() {
    isMac=`uname`
    if [[ -f /etc/redhat-release ]]; then
        OS="CentOS"
    elif [[ -f /etc/lsb-release ]]; then
        grep "Ubuntu" /etc/lsb-release > /dev/null 2>&1
        if [ $? -eq "0" ]; then
            OS="Ubuntu"
        fi
    elif [[ $isMac == "Darwin" ]]; then
        OS="OSX"
    fi
}

function light_print() {
    echo -e "\033[1;37m$1\033[0m"
}
function red_print() {
    echo -e "\033[1;31m$1\033[0m"
}
function green_print() {
    echo -e "\033[1;32m$1\033[0m"
}
function yellow_print() {
    echo -e "\033[1;33m$1\033[0m"
}

function check_procedure () {
    light_print "SYS: Do you want to install $1? [Y/n]"
    read input_key
    if [[ $input_key == "N" ]] || [[ $input_key == "n" ]]; then
        yellow_print "INFO: skip $1 packages" 
    else
        yellow_print "INFO: install $1 packages"
        $2
    fi
}

function install_vifm () {
    return_status=999
    case $OS in
        "CentOS")
            if [ $USER = "root" ]; then
                yum install -y ncurses-libs ncurses-devel ncurses-base ncurses
            else 
                red_print "WARNING:The user has no privileges to install yum packages, sudo yum install"
                sudo yum install -y ncurses-libs ncurses-devel ncurses-base ncurses
            fi
            current=$PWD
            cd env/vifm-0.7.6
            ./configure > /dev/null 2>&1
            make > /dev/null 2>&1
            return_status=$?
            make install > /dev/null 2>&1
            make clean > /dev/null 2>&1
            make distclean > /dev/null 2>&1
            cd $current
            ;;
        "Ubuntu")
            light_print "SYS: sudo apt-get install Ubuntu related packages" 
            sudo apt-get install vifm
            return_status=$?
            ;;
        "OSX")
            brew list > /dev/null 2>&1
            if [[ $? -eq "127" ]]; then
                ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)" 
            fi
            brew install vifm
            return_status=$?
            ;;
    esac

    if [[ $return_status -ne "0" ]]; then
        red_print "ERROR: vifm does not install or install incorrectly"
    else
        green_print "INFO: vifm install successfully"
    fi
}


function install_screen () {
    return_status=999
    case $OS in
        "CentOS")
            if [ $USER = "root" ]; then
                yum install -y screen
            else 
                red_print "WARNING:The user has no privileges to install yum packages, sudo yum install"
                sudo yum install -y screen
            fi
            return_status=$?
            ;;
        "Ubuntu")
            light_print "SYS: sudo apt-get install Ubuntu related packages" 
            sudo apt-get install screen
            return_status=$?
            ;;
        "OSX")
            brew list > /dev/null 2>&1
            if [[ $? -eq "127" ]]; then
                ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)" 
                brew install screen
            else
                brew install screen
            fi
            return_status=$?
            ;;
    esac

    # install screenrc
    if [ -f $HOME/.screenrc ]; then
        mv $HOME/.screenrc $HOME/.screenrc_bak
    fi
    cp -f env/.screenrc $HOME/.screenrc
    alias screen='TERM=xterm-256color screen'

    #### write configuration files ####
    grep "## workenv: screen ##" $HOME/.zshrc > /dev/null 2>&1
    if [ $? -ne "0" ]; then
        echo '## workenv: screen ##' >> $HOME/.zshrc
        echo "alias screen='TERM=xterm-256color screen'" >> $HOME/.zshrc
    fi
    grep "## workenv: screen ##" $HOME/.bash_profile> /dev/null 2>&1
    if [ $? -ne "0" ]; then
        echo '## workenv: screen ##' >> $HOME/.bash_profile
        echo "alias screen='TERM=xterm-256color screen'" >> $HOME/.bash_profile
    fi
 
    if [[ $return_status -ne "0" ]]; then
        red_print "ERROR: screen does not install or install incorrectly"
    else
        green_print "INFO: screen install successfully"
    fi
}

function install_tmux () {
    return_status=999
    case $OS in
        "CentOS")
            if [ $USER = "root" ]; then
                rpm -ivh http://mirror01.idc.hinet.net/EPEL/6/x86_64/epel-release-6-8.noarch.rpm
                yum install -y tmux
            else 
                red_print "WARNING:The user has no privileges to install yum packages, sudo yum install"
                sudo rpm -ivh http://mirror01.idc.hinet.net/EPEL/6/x86_64/epel-release-6-8.noarch.rpm
                sudo yum install -y tmux
            fi
            return_status=$?
            ;;
        "Ubuntu")
            light_print "SYS: sudo apt-get install Ubuntu related packages" 
            sudo apt-get install tmux
            return_status=$?
            ;;
        "OSX")
            brew list > /dev/null 2>&1
            if [[ $? -eq "127" ]]; then
                ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)" 
            fi
            brew install tmux
            return_status=$?
            ;;
    esac

    # install tmux conf
    if [ -f $HOME/.tmux.conf ]; then
        mv $HOME/.tmux.conf $HOME/.tmux.conf.bak
    fi
    cp -f env/.tmux.conf $HOME/.tmux.conf

    alias tmux='DISPLAY=:0.0 TERM=screen-256color tmux -2'
    #### write configuration files ####
    grep "## workenv: tmux ##" $HOME/.zshrc > /dev/null 2>&1
    if [ $? -ne "0" ]; then
        echo '## workenv: tmux ##' >> $HOME/.zshrc
        echo "alias tmux='DISPLAY=:0.0 TERM=screen-256color tmux -2'" >> $HOME/.zshrc
    fi
    grep "## workenv: tmux ##" $HOME/.bash_profile > /dev/null 2>&1
    if [ $? -ne "0" ]; then
        echo '## workenv: tmux ##' >> $HOME/.bash_profile
        echo "alias tmux='DISPLAY=:0.0 TERM=screen-256color tmux -2'" >> $HOME/.bash_profile
    fi
 
    if [[ $return_status -ne "0" ]]; then
        red_print "ERROR: tmux does not install or install incorrectly"
    else
        green_print "INFO: tmux install successfully"
    fi
}


function install_zsh() {
    return_status=999
    case $OS in
        "CentOS")
            if [ $USER = "root" ]; then
                yum install -y zsh
            else 
                red_print "WARNING:The user has no privileges to install yum packages, sudo yum install"
                sudo yum install -y zsh
            fi
            return_status=$?
            echo 'CentOS'
            ;;
        "Ubuntu")
            light_print "SYS: sudo apt-get install Ubuntu related packages" 
            sudo apt-get install zsh
            return_status=$?
            echo 'Ubuntu'
            ;;
        "OSX")
            brew list > /dev/null 2>&1
            if [[ $? -eq "127" ]]; then
                ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)" 
            fi
            brew install zsh
            return_status=$?
            ;;
    esac
    if [ -d $HOME/.oh-my-zsh ]; then
        rm -rf $HOME/.oh-my-zsh_bak
        mv $HOME/.oh-my-zsh $HOME/.oh-my-zsh_bak
    fi
    
    if [ -f $HOME/.zshrc ]; then
        mv $HOME/.zshrc $HOME/.zshrc_bak
    fi

    # turn off dirty check in git repo
    grep "hide-status" $HOME/.gitconfig> /dev/null 2>&1
    if [ $? -ne "0" ]; then
        echo '' >> $HOME/.gitconfig
        echo "[oh-my-zsh]" >> $HOME/.gitconfig
        echo "    hide-status = 1" >> $HOME/.gitconfig
    fi
    
    cp -rf env/oh-my-zsh $HOME/.oh-my-zsh
    cp -f env/.zshrc $HOME/.zshrc

    light_print "SYS: Do you want to change the default shell to zsh? [Y/n]"
    read input_confirm
    if [[ $input_confirm == "N" ]] || [[ $input_confirm == "n" ]]; then
      echo $SHELL 
    else
      chsh -s /bin/zsh
    fi
    
    if [[ $return_status -ne "0" ]]; then
        red_print "ERROR: zsh does not install or install incorrectly"
    else
        green_print "INFO: zsh install successfully"
    fi
}

# Main Install Procedure
detect_os
check_procedure 'vifm' install_vifm
check_procedure 'screen' install_screen
check_procedure 'tmux' install_tmux
check_procedure 'zsh' install_zsh
green_print 'SYS: Finish install env-packages'



