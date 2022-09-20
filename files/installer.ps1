#Recursos
#String random nombre de directorios.
function random_text {
	return -join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_})
}

#Variables 
$wd = random_text
$initial_dir = %cd%
$path = "$env:temp/$wd"

#ir al directorio temporal y hacer directorio funcional
mkdir $path
cd $path
echo "" > poc.txt
cd $initial_dir
del installer.ps1