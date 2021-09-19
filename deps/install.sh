curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
curl -sL https://deb.nodesource.com/setup_14.x -o- | sudo bash

# Basic dependencies
sudo apt update -y
sudo apt-get install software-properties-common unzip -y

# Languages
sudo apt install python3-dev python3-pip nodejs golang lua5.3 -y
sudo pip3 install jedi-language-server
sudo npm install -g pyright
sudo npm install -g yarn
sudo npm install -g yaml-language-server

# Utils
apt install -y fzf ripgrep 

# Terraform
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get install terraform terraform-ls -y

# NEOVIM
wget https://github.com/neovim/neovim/releases/download/v0.5.0/nvim.appimage
chmod +x nvim.appimage
sudo mv -f nvim.appimage /usr/bin/ 
sudo pip3 install neovim

# POWERSHELL EDITOR SERVICES
wget https://github.com/PowerShell/PowerShellEditorServices/releases/download/v2.5.1/PowerShellEditorServices.zip
unzip PowerShellEditorServices.zip -d ~/PowershellES
