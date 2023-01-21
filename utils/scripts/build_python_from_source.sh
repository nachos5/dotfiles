#!/bin/bash

# example usage: 'build_python_from_source.sh 3.11.1'
# takes a long time to finish, so be patient
# when finished, the python version is located here (replace 3.11.1 with your version): /opt/python/3.11.1/bin/python3.11

version=$1

cd /tmp/
wget https://www.python.org/ftp/python/$version/Python-$version.tgz
tar xzf Python-$version.tgz
cd Python-$version

sudo ./configure --prefix=/opt/python/$version/ --enable-optimizations --with-lto --with-computed-gotos --with-system-ffi
sudo make -j "$(nproc)"
sudo make altinstall
sudo rm /tmp/Python-$version.tgz
