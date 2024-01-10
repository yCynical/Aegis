@ECHO OFF
title 
color 3

ECHO *************************************
ECHO CHECKING FOR ADMINISTRATOR PRIVILEGES
ECHO *************************************

::Checks if run by administrator
net session >nul 2>&1
if NOT %errorlevel% == 0 (
ECHO PLESE RUN AS ADMINISTRATOR
GOTO END
) else (
ECHO ADMINISTRATOR LEVEL CONFIRMED
)

REM Install Chocolatey
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

