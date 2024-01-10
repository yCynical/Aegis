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

