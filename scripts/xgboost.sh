sudo apt-get -y install make
sudo apt-get -y update
sudo apt-get -y install gcc
sudo apt-get -y install g++
sudo apt-get -y install git

git clone --recursive https://github.com/dmlc/xgboost
cd xgboost; make -j4

export PYTHONPATH=~/xgboost/python-package
cd ~