#Recursos
#String random nombre de directorios.
function random_text {
	return -join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_})
}

#Variables 
$wd = random_text
$path = "$env:temp/$wd"
$initial_dir = %cd%

#ir al directorio temporal y hacer directorio funcional
mkdir $path
cd $path
echo "" > poc.txt
cd $initial_dir
Set-ExecutionPolicy Unrestricted
s
del installer.ps1