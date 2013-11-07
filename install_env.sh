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
            echo 'CentOS'
            ;;
        "Ubuntu")
            light_print "SYS: sudo apt-get install Ubuntu related packages" 
            sudo apt-get install screen
            return_status=$?
            echo 'Ubuntu'
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

    #### write configuration files ####
    grep "## workenv: screen ##" $HOME/.zshenv > /dev/null 2>&1
    if [ $? -ne "0" ]; then
        echo '## workenv: screen ##' >> $HOME/.zshenv
        echo "alias screen='TERM=xterm-256color screen'" >> $HOME/.zshenv
    fi
 
    if [[ $return_status -ne "0" ]]; then
        red_print "ERROR: screen does not install or install incorrectly"
    else
        green_print "INFO: screen install successfully"
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
    
    cp -rf env/oh-my-zsh $HOME/.oh-my-zsh
    cp -f env/.zshrc $HOME/.zshrc

    light_print "SYS: Do you want to change the default shell to zsh? [Y/n]"
    read input_confirm
    if [[ $input_confirm == "N" ]] || [[ $input_confirm == "n" ]]; then
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
check_procedure 'screen' install_screen
check_procedure 'zsh' install_zsh
green_print 'SYS: Finish install env-packages'



