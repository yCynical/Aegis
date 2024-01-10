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

REM Admin & Guest
    net user administrator /active:no
    net user guest /active:no

REM Set the password policy & complexity requirments
	echo Setting password policies
	net accounts /minpwlen:8
	net accounts /maxpwage:60
	net accounts /minpwage:10
	net accounts /uniquepw:3

REM Sets the lockout policy
	echo Setting the lockout policy
	net accounts /lockoutduration:30
	net accounts /lockoutthreshold:3
	net accounts /lockoutwindow:30

REM Firewall
    netsh advfirewall set allprofiles state on
	netsh advfirewall reset

REM Automatic Windows Updates
	echo Turning on automatic updates
	reg add "HKLM\SOFTWARE\Microsoft\WINDOWS\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 4 /f

REM Auditing
	echo Auditing the maching now
	auditpol /set /category:* /success:enable
	auditpol /set /category:* /failure:enable

REM TELNET SERVICES
    dism /online /Disable-feature /featurename:TelnetClient /NoRestart
    dism /online /Disable-feature /featurename:TelnetServer /NoRestart 

REM CHOCO INSTALLS
    choco install malwarebytes -y

REM SYSINTERNALS KIT 
    net use x: \\live.sysinternals.com\Tools\
    xcopy /s x:\ c:\sysinternals\
    net use x: /d
	echo "SysInternals kit is in the C drive."

REM NIRSOFT Tools
    echo "Install of all NIRSOFT tools is available at https://www.nirsoft.net"

REM Autopsy Tool
	echo "Install is from https://www.autopsy.com/download/"
