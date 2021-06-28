
# Install Fonts
$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
Get-ChildItem fonts/*.ttf | % {
    Write-Host "Installing font: $($_.Name)"
    $fonts.CopyHere($_.fullname)
}

# Install packages
powershell.exe -File deps/install.ps1 
