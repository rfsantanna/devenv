choco install terraform -y --version 1.0.6 --force
choco install psscriptanalyzer -y
choco install neovim --version 0.5.0  -y
choco install powershell-core -y

pip install neovim
pip install jedi-language-server
npm install -g pyright
npm install -g yarn
yarn add yaml-language-server


# TERRAFORM-LS
Invoke-WebRequest -Uri "https://releases.hashicorp.com/terraform-ls/0.22.0/terraform-ls_0.22.0_windows_amd64.zip" -OutFile terraform-ls.zip
Expand-Archive -Path terraform-ls.zip -DestinationPath C:\ProgramData\chocolatey\bin -Verbose -force

# POWERSHELL EDITOR SERVICES
Invoke-WebRequest https://github.com/PowerShell/PowerShellEditorServices/releases/download/v2.5.1/PowerShellEditorServices.zip -OutFile PowerShellEditorServices.zip
Expand-Archive -Path PowerShellEditorServices.zip -DestinationPath C:/users/$env:USERNAME/PowershellES -Force 


