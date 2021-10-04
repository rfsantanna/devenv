Param(
    $NeovimVersion = "0.5.0",
    $PowershellESVersion = "2.5.1",
    $TerraformVersion = "1.0.7",
    $TerraformLSVersion = "0.22.0" 
)

# Basic
choco install microsoft-windows-terminal -y
choco install aria2 psscriptanalyzer powershell-core -y

# NEOVIM
choco install neovim --version $NeovimVersion -y
pip install neovim

# Language
pip install jedi-language-server
npm install -g pyright
npm install -g yarn
yarn add yaml-language-server

# TERRAFORM
choco install terraform -y --version $TerraformVersion --force
Invoke-WebRequest -Uri "https://releases.hashicorp.com/terraform-ls/$TerraformLSVersion/terraform-ls_$($TerraformLSVersion)_windows_amd64.zip" -OutFile terraform-ls.zip
Expand-Archive -Path terraform-ls.zip -DestinationPath C:\ProgramData\chocolatey\bin -Verbose -force

# POWERSHELL EDITOR SERVICES
Invoke-WebRequest https://github.com/PowerShell/PowerShellEditorServices/releases/download/v$PowershellESVersion/PowerShellEditorServices.zip -OutFile PowerShellEditorServices.zip
Expand-Archive -Path PowerShellEditorServices.zip -DestinationPath C:/users/$env:USERNAME/PowershellES -Force 


