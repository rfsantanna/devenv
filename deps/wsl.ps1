Param(
    [Parameter(Mandatory)][ValidateSet('Install','Remove','Backup','Restore','ImportCert','SetupPackages')]$Action,
	$Username = $env:USERNAME,
    $RootFSUrl = "https://cloud-images.ubuntu.com/releases/impish/release/ubuntu-21.10-server-cloudimg-amd64-wsl.rootfs.tar.gz",
    $Name = "Ubuntu2110",
    $Cert = "\\afs\Areas\TI\Compartilhado\wsl\ca-raiz.crt",
    $Directory = "C:\$Name",
    $BackupFile = "$(Join-Path $HOME `"wsl-$name-backup.tar`")",
    $WSLVersion = 1,
    $AFSPath = "\\afs\Areas\TI\Compartilhado\wsl\ubuntu_rootfs_2110.tar.gz",
	[switch]$RemoteUrl,
	[switch]$SetPassword
)


function Set-WSLDefaultUser($Username, $Distribution) {
    If (-Not $Username) { $Username = "root" }
    $USERID = wsl -d $Distribution bash -c "id -u $Username" 
    Write-Host("`n:: Set default username in WSL")
    Get-ItemProperty Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss\* `
        | Where-Object DistributionName -eq "$Distribution" `
        | Set-ItemProperty -Name DefaultUid -Value $USERID	
}

function Clear-WSLDirectory($Directory) {
    Write-Host("`n:: Cleaning directory $Directory")
    Remove-Item -recurse -Force $Directory -ErrorAction SilentlyContinue
    mkdir $Directory -ErrorAction SilentlyContinue | out-null
}

function Set-WSLDefaultDistro($Distribution) {
    Write-Host("`n:: Set $Distribution as default WSL image")
    wsl --set-default $Distribution
}

function Get-WSLImageURL($Distribution, $Version) {
    switch ($Distribution) {
        Ubuntu {
	    $ImageURL = $RootFSUrl
            return $ImageURL
        }
        default {
            Write-Error "Distribution not Found" -ErrorAction Stop
        }
    }
}

function Import-WSLCert($Cert, $Distribution) {
    Write-Host("`n:: Import $Cert to $Distribution")
    $CertName = (Get-Item -Path $cert).BaseName + ".crt"
    Copy-Item -Path $Cert -Destination C:/tmpcert.crt
    wsl -d $Distribution -- sudo mv /mnt/c/tmpcert.crt /usr/local/share/ca-certificates/$CertName
    wsl -d $Distribution -- sudo update-ca-certificates
}


switch ($Action) {
    Install {
        if ($RemoteUrl) {
            $ImageURL = Get-WSLImageURL -Distribution Ubuntu -Version $UbuntuRootfsUrl
            Write-Host("`n:: Installing Aria2")
            choco install aria2 -y
            Write-Host("`n:: Downloading Image")
            aria2c -o rootfs.tar.gz -c -s 16 -x 16 -k 1M -j 1 --file-allocation=none  $ImageURL	
        } Else { Copy-Item $AFSPath rootfs.tar.gz }


        Clear-WSLDirectory -Directory $Directory
        Write-Host("`n:: Importing rootfs")
        wsl --import $Name $Directory .\rootfs.tar.gz

        If ($username) {
            Write-Host("`n:: Adding user $Username")
            wsl -d $name bash -c "useradd -m $Username -s /bin/bash"

            Write-Host("`n:: Include user in sudoers")
            wsl -d $name bash -c  "echo '$USerName ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/defaultuser"

            If ($SetPassword) {
                Write-Host("`n:: Set $username Password")
                wsl -d $name bash -c "passwd $Username"
            }
            Set-WSLDefaultUser -Username $Username -Distribution $Name
        }
        Set-WSLDefaultDistro -Distribution $Name
        #Import-WSLCert -Distribution $Name -Cert $cert
         
        Write-Host("`n:: Ignore SSL certs on apt")
        bash -c "echo -e 'Acquire::https::Verify-Peer `"false`";\nAcquire::https::Verify-Host `"false`";' | sudo tee /etc/apt/apt.conf.d/98ignore-ssl"
    }

    Remove {
        wsl --unregister $Name
    }

    Backup {
        Write-Host("`n:: Starting $Name Backup")
        wsl --export $Name $BackupFile
    }

    Restore {
        $ErrorActionPreference = "SilentlyContinue"
        wsl --unregister $Name
        $ErrorActionPreference = "Stop"
        Clear-WSLDirectory -Directory $Directory
        Write-Host("`n:: Restoring to $Directory")
        wsl --import $Name $Directory $BackupFile
        Set-WSLDefaultDistro -Distribution $Name
        Set-WSLDefaultUser -Username $Username -Distribution $Name
    }

    ImportCert {
        Import-WSLCert -Cert $Cert -Distribution $Name
    }

    SetupPackages {
        $Script = "\\afs\Areas\TI\Compartilhado\wsl\install_packages.sh"
        Write-Host("`n:: Copy file $Script to $Name")
        Copy-Item -Path $Script -Destination C:/tmpscript.sh -Force
        wsl -d $Name -- sudo mv /mnt/c/tmpscript.sh /tmp/install_packages.sh
        wsl -d $Name -- sudo bash /tmp/install_packages.sh
    }

    default {
        Write-Host("Wrong Action")
    }
}

