#!/bin/bash


f_title() {
  echo
  echo "### $@"
}


CONF_TYPE=$1

if [ "$CONF_TYPE" == 'bash' ]; then
  f_title "BASH :: Copying config files"
  cp -vi bash/bashrc ~/.bashrc
  cp -vi bash/bash_prompt ~/.bash_prompt
  cp -vi bash/bash_alias ~/.bash_alias
  source ~/.bashrc

elif [ "$CONF_TYPE" == 'git' ]; then
  f_title "GIT :: Copying config files"
  cp -vi git/gitconfig ~/.gitconfig

elif [ "$CONF_TYPE" == 'vim' ]; then
  apt install python nodejs vim git neovim
  pip install neovim
  f_title "VIM :: Copying config files"
  mkdir ~/.vim 2> /dev/null
  cp -vi vim/vim/vimrc ~/.vimrc
  cp -vR vim/vim/colors ~/.vim/
  f_title "VIM :: Installing Plugins"
  vim +'PlugClean --sync' +qa &> /dev/null
  vim +'PlugInstall --sync' +qa  &> /dev/null

elif [ "$CONF_TYPE" == 'nvim' ]; then
  apt install python nodejs vim git neovim
  pip install neovim
  f_title "NVIM :: Installing vim-plug"
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  f_title "NVIM :: Copying config files"
  cp -vi vim/init.vim ~/.config/nvim/
  cp -vR vim/defaults/* ~/.config/nvim/
  f_title "NVIM :: Installing Plugins"
  nvim --headless +PlugInstall +qall

elif [ "$CONF_TYPE" == 'fix-ansible-vim' ]; then
  PLUG_DIR=~/.vim/plugged/ansible-vim
  f_title "VIM :: Fix ansible-vim loop highlight and Indentation"
  sed -i 's/^setlocal indentkeys.*/setlocal indentkeys=!^F,o,O,0#,0},0] ",<:>,-,*<Return>/g' \
    ${PLUG_DIR}/indent/ansible.vim && echo ${PLUG_DIR}/indent -- OK
  sed -i 's/with_.+\"/with_.+\|loop.+\"/g' \
    ${PLUG_DIR}/syntax/ansible.vim && echo ${PLUG_DIR}/syntax -- OK 

elif [ "$CONF_TYPE" == 'termux' ]; then
  f_title "TERMUX :: Copying config files"
  mkdir ~/.termux 2> /dev/null
  cp termux/* ~/.termux

elif [ "$CONF_TYPE" == 'msys' ]; then
  f_title "MSYS :: Installing packages"
  bash extras/msys2/setup_msys.sh

elif [ "$CONF_TYPE" == 'dev' ]; then
  bash $0 bash
  bash $0 git
  bash $0 nvim

else
  f_title "Argument error! "
  echo '### Valid args: bash|git|vim|nvim|termux|msys'
  echo '                fix-ansible-vim|dev(bash+git+vim)'
  echo "Ex.: $0 dev"

fi
