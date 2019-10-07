#!/usr/bin/bash

# Setup Msys2

pacman -Syyu
pacman -S sshpass vim openssh nano python2 python2-pip \
   python3 python3-pip libyaml-devel tar libffi libffi-devel \
   gcc pkg-config make openssl-devel libcrypt-devel git subversion
   
