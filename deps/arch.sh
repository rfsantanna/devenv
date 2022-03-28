sudo pacman -Sy
sudo pacman -S --noconfirm ripgrep terraform nodejs unzip zip fzf neovim vivid python-pip ansible go lua base-devel yarn github-cli python-pywinrm
yay -S --noconfirm powershell-bin

sudo pacman -S --noconfirm jedi-language-server ansible-lint
sudo yarn add pyright
sudo yarn add yaml-language-server


yay -S --noconfirm azure-cli terraform-ls
sudo az extension add --name azure-devops

# POWERSHELL EDITOR SERVICES
wget https://github.com/PowerShell/PowerShellEditorServices/releases/download/v3.1.6/PowerShellEditorServices.zip
unzip PowerShellEditorServices.zip -d ~/.PowershellES > /dev/null


yay -S --noconfirm icaclient
sudo ln -s /usr/lib/libunwind.so.8.0.1 /usr/lib/libunwind.so.1


sed -i s'/^#AutoEnable\s*=.*/AutoEnable=true/g' /etc/bluetooth/main.conf
sed -i s'/^#DiscoverableTimeout\s*=.*/DiscoverableTimeout=0/g' /etc/bluetooth/main.conf
