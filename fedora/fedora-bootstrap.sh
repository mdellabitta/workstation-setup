#!/usr/bin/bash

# The purpose of this script is to get the box set up for running the
# ansible playbooks in the repo. We're installing the latest ansible
# using pip, and pip and a recent python using pyenv.

# Script is written assuming Raspbian. May work elsewhere. In the case
# of the Vagrantfile in this repo, it's working in Debian x86-64. 

set -euxo pipefail

echo '---> Updating package list'
sudo dnf update

# Most of these dependencies are here to get python builds working.
echo '---> Installing packages'
sudo dnf install -y \
	git \
	make \
	gcc \
	zlib-devel \
	bzip2 \
	bzip2-devel \
	readline-devel \
	sqlite \
	sqlite-devel \
	openssl-devel \
	tk-devel \
	libffi-devel \
	xz-devel

if ! [[ -d $HOME/.pyenv ]]
then
        echo '---> Downloading and building pyenv'
	git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
        cd $HOME/.pyenv && src/configure && make -C src; cd -
fi

if ! grep -q pyenv $HOME/.bashrc
then
    echo '---> Installing pyenv into .bashrc'
    echo 'export PYENV_ROOT="$HOME/.pyenv"' > $HOME/bashrc.tmp
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/bashrc.tmp
    echo 'eval "$(pyenv init --path)"' >> $HOME/bashrc.tmp
    cat $HOME/.bashrc >> $HOME/bashrc.tmp
    mv $HOME/.bashrc $HOME/.bashrc.bak.$(timestamp=$(date +%s))
    mv $HOME/bashrc.tmp $HOME/.bashrc

    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"	
fi

echo '---> Installing python 3.10.4 and setting it as default'
pyenv install -s 3.10.4
pyenv global 3.10.4

echo '---> Upgrading pip'
pip install --upgrade pip

echo '---> Installing Python wheel and setuptools'
pip install --upgrade wheel setuptools

echo '---> Installing ansible and requirements'
pip install ansible
