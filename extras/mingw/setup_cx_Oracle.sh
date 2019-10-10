#!/usr/bin/bash

# DOWNLOAD INSTANT CLIENT
# START VENV
set -e

ORAIC='/c/oracle/instantclient_11_2'

echo ':: INSTALANDO PACOTES NECESSARIOS'
pacman -S --noconfirm python3 python3-pip mingw-w64-x86_64-toolchain 

echo ':: INSTALANDO CX_ORACLE'
python -m pip install cx_Oracle

echo ':: ATUALIZANDO BASHRC'
grep "PATH=$ORAIC" ~/.bashrc || { 
  echo "export PATH=$ORAIC:"'$PATH' >> ~/.bashrc  
}

