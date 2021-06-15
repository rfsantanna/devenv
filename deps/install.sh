curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt update -y
sudo apt install neovim -y
sudo apt install python3-dev python3-pip npm -y
sudo apt-get install terraform

sudo npm install -g pyright
sudo pip3 install neovim
