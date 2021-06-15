curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
curl -sL https://deb.nodesource.com/setup_14.x -o- | sudo bash
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt update -y
sudo apt install neovim -y
sudo apt install python3-dev python3-pip nodejs -y
sudo apt-get install terraform -y

sudo npm install -g pyright
sudo pip3 install neovim
