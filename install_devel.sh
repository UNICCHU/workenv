#!/bin/env bash

YUM_PACKAGES=" python python-setuptools gcc zlib-devel openssl   \
               openssl-devel mysql-devel readline readline-devel \
               readline-static openssl-static sqlite-devel       \
               bzip2-devel bzip2-libs"

DPKG_PACKAGES=" gcc build-essential zlib1g-dev python            \ 
                python-setuptools libssl-dev openssl-dev         \ 
                mysql-dev "

INSTALL_PYTHON="2.7.5"
PYTHON_PACKAGES="readline ipython virtualenv virtualenvwrapper nose"

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


function install_devel () {
    return_status=999
    case $OS in
        "CentOS")
            if [ $USER = "root" ]; then
                yum install -y $YUM_PACKAGES
            else 
                red_print "WARNING:The user has no privileges to install yum packages, sudo yum install"
                sudo yum install -y $YUM_PACKAGES
            fi
            return_status=$?
            echo 'CentOS'
            ;;
        "Ubuntu")
            light_print "SYS: sudo apt-get install Ubuntu related python packages" 
            sudo apt-get install $DPKG_PACKAGES
            return_status=$?
            echo 'Ubuntu'
            ;;
        "OSX")
            brew list > /dev/null 2>&1
            if [[ $? -eq "127" ]]; then
                #http://brew.sh/
                ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)" 
            fi
            return_status=$?
            ;;
    esac
    if [[ $return_status -ne "0" ]]; then
        red_print "ERROR: devel does not install or install incorrectly"
    else
        green_print "INFO: devel install successfully"
    fi
}

function install_pyenv () {
   return_status=999
   case $OS in
        "CentOS"|"Ubuntu")
            if [ ! -d devel/pyenv ]; then
                red_print "ERROR: make sure to execute update_module.sh first"
                break
            fi
            if [ ! -d $HOME/.pyenv ]; then
                yellow_print "INFO: installing pyenv ..." 
                cp -rf devel/pyenv $HOME/.pyenv
            fi
            return_status=$?
            ;;
        "OSX")
            yellow_print "INFO: brew installing pyenv ..."
            brew install pyenv
            return_status=$?
            ;;
    esac
    
    #### Setting .pyenv PATH ####
    export PATH=$HOME/.pyenv/bin:$PATH
    eval "$(pyenv init -)"

    #### write configuration files ####
    grep "## workenv: pyenv ##" $HOME/.bash_profile > /dev/null 2>&1
    if [ $? -ne "0" ]; then
        echo '## workenv: pyenv ##' >> $HOME/.bash_profile
        echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> $HOME/.bash_profile
        echo 'eval "$(pyenv init -)"' >> $HOME/.bash_profile
    fi
    
    grep "## workenv: pyenv ##" $HOME/.zshrc > /dev/null 2>&1
    if [ $? -ne "0" ]; then
        echo "## workenv: pyenv ##" >> $HOME/.zshrc
        echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> $HOME/.zshrc
        echo 'eval "$(pyenv init -)"' >> $HOME/.zshrc
    fi

    if [[ $return_status -ne "0" ]]; then
        red_print "ERROR: pyenv does not install or install incorrectly"
        return
    else
        green_print "INFO: pyenv install successfully"
    fi

    #### Install specific python packages ####
    python_version="python:"$INSTALL_PYTHON
    check_procedure $python_version install_pyenv_python

}

function install_pyenv_python () {
    #### Install specific python packages ####
    pyenv install $INSTALL_PYTHON
    pyenv global $INSTALL_PYTHON
    pyenv versions
}

function install_python_module () {
    return_status=999
    pip install $PYTHON_PACKAGES
    return_status=$?

    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/bin/virtualenvwrapper.sh

    #### write configuration files ####
    grep "## workenv: virtualenv ##" $HOME/.bash_profile
    if [ $? -ne "0" ]; then
        echo '## workenv: virtualenv ##' >> $HOME/.bash_profile
        echo 'export WORKON_HOME=$HOME/.virtualenvs' >> $HOME/.bash_profile
        echo 'source /usr/bin/virtualenvwrapper.sh' >> $HOME/.bash_profile
    fi
    
    if [ -f $HOME/.zshrc ]; then
        grep "## workenv: virtualenv ##" $HOME/.zshrc
        if [ $? -ne "0" ]; then
            echo "## workenv: virtualenv ##" >> $HOME/.zshrc
            echo 'export WORKON_HOME=$HOME/.virtualenvs' >> $HOME/.zshrc
            echo 'source /usr/bin/virtualenvwrapper.sh' >> $HOME/.zshrc
        fi
    fi

    if [[ $return_status -ne "0" ]]; then
        red_print "ERROR: python modules does not install or install incorrectly"
    else 
        green_print "INFO: python module install successfully"
    fi
}


# Main Install Procedure
detect_os
check_procedure 'devel-packages' install_devel
check_procedure 'pyenv' install_pyenv
check_procedure 'python modules' install_python_module
green_print "SYS: finish installing devel packages."


