#!/bin/bash


f_title() {
  echo
  echo "### $@"
}


CONF_TYPE=$1

if [ "$CONF_TYPE" == 'bash' ]; then
  f_title "BASH :: Copying config files"
  cp -vi defaults/bashrc ~/.bashrc
  cp -vi defaults/bash_prompt ~/.bash_prompt
  source ~/.bashrc

elif [ "$CONF_TYPE" == 'git' ]; then
  f_title "GIT :: Copying config files"
  cp -vi defaults/gitconfig ~/.gitconfig

elif [ "$CONF_TYPE" == 'vim' ]; then
  f_title "VIM :: Copying config files"
  mkdir ~/.vim 2> /dev/null
  cp -vi defaults/vim/vimrc ~/.vimrc
  cp -vR defaults/vim/colors ~/.vim/
  f_title "VIM :: Installing Plugins"
  vim +'PlugClean --sync' +qa &> /dev/null
  vim +'PlugInstall --sync' +qa  &> /dev/null

elif [ "$CONF_TYPE" == 'termux' ]; then
  f_title "TERMUX :: Copying config files"
  mkdir ~/.termux 2> /dev/null
  cp extras/termux/* ~/.termux

elif [ "$CONF_TYPE" == 'msys' ]; then
  f_title "MSYS :: Installing packages"
  bash extras/msys2/setup_msys.sh

elif [ "$CONF_TYPE" == 'dev' ]; then
  bash $0 bash
  bash $0 git
  bash $0 vim

else
  f_title "Argument error! "
  echo '### Valid args: bash|git|vim|termux|msys|dev(bash+git+vim)'
  echo "Ex.: $0 dev"

fi
