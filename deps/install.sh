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
sudo yarn add yaml-language-server

# Utils
sudo apt install -y fzf ripgrep vivid
# Vivid
wget "https://github.com/sharkdp/vivid/releases/download/v0.7.0/vivid_0.7.0_amd64.deb"
sudo dpkg -i vivid_0.7.0_amd64.deb


# Terraform
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" -y
sudo apt-get install terraform terraform-ls -y

# Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az extension add --name azure-devops

# NEOVIM
cat /etc/issue | grep -i ubuntu && {
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt update && sudo apt install neovim
} || {
    wget https://github.com/neovim/neovim/releases/download/v0.5.1/nvim.appimage
    chmod +x nvim.appimage
    sudo mv -f nvim.appimage /usr/bin/nvim
}
sudo pip3 install neovim

# POWERSHELL EDITOR SERVICES
wget https://github.com/PowerShell/PowerShellEditorServices/releases/download/v2.5.1/PowerShellEditorServices.zip
unzip PowerShellEditorServices.zip -d ~/PowershellES

#Fonts
sudo apt install fonts-hack-ttf -y
