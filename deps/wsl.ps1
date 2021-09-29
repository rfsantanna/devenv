Param(
    $UbuntuVersion = "21.04",
	$Name = "Ubuntu2104",
	$Username = "",
    $WSLVersion = 1,
	[switch]$AFS,
	[switch]$SkipPassword,
    [Parameter(Mandatory)][ValidateSet('Install','Remove','Backup','Restore')]$Action
)

switch ($Action) {
    Install {
        if (-NOT $AFS) {
            $ImageURL = "https://cloud-images.ubuntu.com/releases/hirsute/release-20210928/ubuntu-21.04-server-cloudimg-amd64-wsl.rootfs.tar.gz"
            Write-Host("`n:: Installing Aria2")
            choco install aria2 -y
            Write-Host("`n:: Downloading Image")
            aria2c -o rootfs.tar.gz -c -s 16 -x 16 -k 1M -j 1 --file-allocation=none  $ImageURL	
        } Else {cp \\afs\Tools\Setup\Instaladores\UbuntuWSL\rootfs.tar.gz . }

        Write-Host("`n:: Cleaning directory C:\$Name")
        rmdir -recurse -Force C:/$Name -ErrorAction SilentlyContinue
        mkdir C:/$Name -ErrorAction SilentlyContinue | out-null

        Write-Host("`n:: Set default version to $WSLVersion")
        wsl --set-default-version $WSLVersion

        Write-Host("`n:: Importing rootfs")
        wsl --import $Name C:/$Name .\rootfs.tar.gz

        If ($username) {
            Write-Host("`n:: Adding user $Username")
            wsl -d $name bash -c "useradd -m $Username"

            Write-Host("`n:: Include user in sudoers")
            wsl -d $name bash -c  "echo '$USerName ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/defaultuser"

            If (-NOT $SkipPassword) {
                Write-Host("`n:: Set $username Password")
                wsl -d $name bash -c "passwd $Username"
            }

            Write-Host("`n:: Set default username in WSL")
            $USERID = wsl -d $Name bash -c "id -u $Username" 
            Get-ItemProperty Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Lxss\* `
                | Where DistributionName -eq "$Name" `
                | Set-ItemProperty -Name DefaultUid -Value $USERID	
        }

        Write-Host("`n:: Set $Name as default WSL image")
        wsl --set-default $Name

        Write-Host("`n:: Running $Name")
        bash
    }

    Remove {
        wsl --unregister $Name
    }

    Backup {
        Write-Host("`n:: Starting $Name Backup")
        wsl --export $name (Join-Path $HOME "wsl-$name-backup.tar")
    }

    Restore {
        Write-Host("`n:: Restoring to C:\$Name")
        wsl --import $name C:/$name (Join-Path $HOME "wsl-$name-backup.tar")

        Write-Host("`n:: Set $Name as default WSL image")
        wsl --set-default $Name
    }

    default {
        Write-Host("Wrong Action")
    }

}

