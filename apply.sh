#!/bin/bash


CONF_TYPE=$1



if [ $CONF_TYPE == 'bash' ]; then
  cp -vi defaults/bashrc ~/.bashrc
  cp -vi defaults/bash_prompt ~/.bash_prompt
  source ~/.bashrc

elif [ $CONF_TYPE == 'git' ]; then
  cp -vi defaults/gitconfig ~/.gitconfig

elif [ $CONF_TYPE == 'vim' ]; then
  mkdir ~/.vim 2> /dev/null
  cp -vi defaults/vim/vimrc ~/.vimrc
  cp -vR defaults/vim/colors ~/.vim/
  vim +'PlugClean --sync' +qa  
  vim +'PlugInstall --sync' +qa  

elif [ $CONF_TYPE == 'termux' ]; then
  mkdir ~/.termux 2> /dev/null
  cp extras/termux/* ~/.termux

elif [ $CONF_TYPE == 'msys' ]; then
  bash extras/msys2/setup_msys.sh

elif [ $CONF_TYPE == 'dev' ]; then
  bash $0 bash
  bash $0 git
  bash $0 vim

else
  echo "Argument error:"
  echo "Options: bash, git, vim, termux, msys"

fi
