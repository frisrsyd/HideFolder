@echo off
title Folder Private
if EXIST "HTG Locker" goto UNLOCK
if EXIST Private goto CONFIRM
if NOT EXIST Private goto MDLOCKER

:SETUP
echo Please set a password:
set /p "newpass=>"
if EXIST password.txt (
    attrib -h -s "password.txt"
    del password.txt
)
echo %newpass% > password.txt
attrib +h +s "password.txt"
echo Password has been set.
goto END

:CONFIRM
echo Do you want to lock the folder? (Y/N)
set /p "cho=>"
if /I "%cho%"=="Y" goto LOCK
if /I "%cho%"=="N" goto END
echo Invalid choice.
goto CONFIRM

:LOCK
ren Private "HTG LOCKER"
attrib +h +s "HTG LOCKER"
echo Folder locked
goto END

:UNLOCK
if NOT EXIST password.txt goto SETUP
echo Please enter your password to unlock:
set /p "pass=>"
set /p "savedpass=" < password.txt
setlocal enabledelayedexpansion
set savedpass=!savedpass:~0,-1!
endlocal & set savedpass=%savedpass%
if NOT "%pass%"=="%savedpass%" goto FAIL
attrib -h -s "HTG LOCKER"
ren "HTG LOCKER" Private
echo Folder unlocked successfully
goto END

:FAIL
echo Invalid password.
goto END

:MDLOCKER
md Private
goto SETUP

:END
exit
