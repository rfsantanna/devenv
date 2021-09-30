Param(
    [Parameter(Mandatory)][ValidateSet('Install','Remove','Backup','Restore')]$Action,
	$Username = "",
    $UbuntuVersion = "21.04",
	$Name = "Ubuntu2104",
    $Directory = "C:\$Name",
    $BackupFile = "$(Join-Path $HOME `"wsl-$name-backup.tar`")",
    $WSLVersion = 1,
	[switch]$AFS,
	[switch]$SkipPassword
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
            $ImageURL = "https://cloud-images.ubuntu.com/releases/hirsute/release-20210928/ubuntu-$UbuntuVersion-server-cloudimg-amd64-wsl.rootfs.tar.gz"
            return $ImageURL
        }
        default {
            Write-Error "Distribution not Found" -ErrorAction Stop
        }
    }
}



switch ($Action) {
    Install {
        if (-NOT $AFS) {
            $ImageURL = Get-WSLImageURL -Distribution Ubuntu -Version 21.04
            Write-Host("`n:: Installing Aria2")
            choco install aria2 -y
            Write-Host("`n:: Downloading Image")
            aria2c -o rootfs.tar.gz -c -s 16 -x 16 -k 1M -j 1 --file-allocation=none  $ImageURL	
        } Else {Copy-Item \\afs\Tools\Setup\Instaladores\UbuntuWSL\rootfs.tar.gz . }


        Clear-WSLDirectory -Directory $Directory
        Write-Host("`n:: Importing rootfs")
        wsl --import $Name $Directory .\rootfs.tar.gz

        If ($username) {
            Write-Host("`n:: Adding user $Username")
            wsl -d $name bash -c "useradd -m $Username -s /bin/bash"

            Write-Host("`n:: Include user in sudoers")
            wsl -d $name bash -c  "echo '$USerName ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/defaultuser"

            If (-NOT $SkipPassword) {
                Write-Host("`n:: Set $username Password")
                wsl -d $name bash -c "passwd $Username"
            }
            Set-WSLDefaultUser -Username $Username -Distribution $Name
        }
        Set-WSLDefaultDistro -Distribution $Name
        Write-Host("`n:: Running $Name")
        bash
    }

    Remove {
        wsl --unregister $Name
    }

    Backup {
        Write-Host("`n:: Starting $Name Backup")
        wsl --export $Name $BackupFile
    }

    Restore {
        Clear-WSLDirectory -Directory $Directory
        Write-Host("`n:: Restoring to $Directory")
        wsl --import $Name $Directory $BackupFile
        Set-WSLDefaultDistro -Distribution $Name
        Set-WSLDefaultUser -Username $Username -Distribution $Name
    }

    default {
        Write-Host("Wrong Action")
    }
}

