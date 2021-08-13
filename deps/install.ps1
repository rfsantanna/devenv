# windows deployment
#
# 
# terraform-ls
# powershell lang server
#

choco install fzf nodejs python powershell-core kubernetes-cli glow golang ripgrep -y
choco install terraform --version 0.13.3 -y
choco install psscriptanalyzer -y
choco upgrade neovim --pre --force -y
pip install neovim
pip install jedi-language-server
npm install -g pyright
npm install -g yaml-language-server

