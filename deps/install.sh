# Ignore ssl certs on apt
echo 'Acquire::https::Verify-Peer "false";' > /etc/apt/apt.conf.d/98ignore-ssl
echo 'Acquire::https::Verify-Host "false";' >> /etc/apt/apt.conf.d/98ignore-ssl

# Add keys
curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/hashicorp-archive-keyring.gpg >/dev/null
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
sudo apt install -y fzf ripgrep fonts-hack-ttf
wget "https://github.com/sharkdp/vivid/releases/download/v0.8.0/vivid_0.8.0_amd64.deb"
sudo dpkg -i vivid_0.8.0_amd64.deb

# Terraform
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" -y
sudo apt-get install terraform terraform-ls -y

# NEOVIM
cat /etc/issue | grep -i ubuntu && {
    sudo add-apt-repository ppa:neovim-ppa/stable -y
    sudo apt update && sudo apt install neovim
} || {
    wget https://github.com/neovim/neovim/releases/download/v0.5.1/nvim.appimage
    chmod +x nvim.appimage
    sudo mv -f nvim.appimage /usr/bin/nvim
}
sudo pip3 install neovim

# POWERSHELL EDITOR SERVICES
wget https://github.com/PowerShell/PowerShellEditorServices/releases/download/v3.1.3/PowerShellEditorServices.zip
unzip PowerShellEditorServices.zip -d ~/PowershellES

# Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az extension add --name azure-devops

# Ansible
sudo apt-get install libffi-dev libssl-dev -y
pip install pywinrm
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt-get install -y ansible ansible-lint

