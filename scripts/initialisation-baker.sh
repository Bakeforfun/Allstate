#!/usr/bin/env bash

cd ~
wget https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh
bash Anaconda3-4.2.0-Linux-x86_64.sh -b
echo 'PATH="/home/baker/anaconda3/bin:$PATH"' >> .bashrc
. ~/.bashrc

sudo apt-get -y install make
sudo apt-get -y update
sudo apt-get -y install gcc
sudo apt-get -y install g++
sudo apt-get -y install git

git clone --recursive https://github.com/dmlc/xgboost
cd xgboost; make -j4

export PYTHONPATH=~/xgboost/python-package
cd ~

jupyter notebook --generate-config

key=$(python -c "from notebook.auth import passwd; print(passwd())")

cd ~
mkdir certs
cd certs
certdir=$(pwd)
openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mycert.key -out mycert.pem

cd ~
sed -i "1 a\
c = get_config()\\
c.NotebookApp.certfile = u'$certdir/mycert.pem'\\
c.NotebookApp.keyfile = u'$certdir/mycert.key'\\
c.NotebookApp.ip = '*'\\
c.NotebookApp.open_browser = False\\
c.NotebookApp.password = u'$key'\\
c.NotebookApp.port = 8888" .jupyter/jupyter_notebook_config.py
