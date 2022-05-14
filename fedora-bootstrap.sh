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
	echo '---> Installing pyenv'
	curl https://pyenv.run | bash

	PYENV_ROOT="$HOME/.pyenv"
	PATH="$PYENV_ROOT/bin:$PATH"; 
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