::
::   File: KillServer.bat
:: Author: Dalton Perkins
::
:: Description:
:: Close both running servers, update the servers, then reboot
:: the servers to intsall mods.

@echo off

SET SteamLocation=C:\Apps\Steam
SET ServerLocation=C:\Servers\
SET ServerOneName=TheIsland
SET ServerTwoName=ScorchedEarth

:: _________________________________________________________

::Kill Both Servers
taskkill /IM ShooterGameServer.exe > nul
taskkill /IM ShooterGameServer.exe > nul

timeout /t 5 /nobreak > nul
:: _________________________________________________________
:: Update Server One
SETLOCAL ENABLEDELAYEDEXPANSION

    SET STEAMLOGIN=anonymous
    SET ARKserverBRANCH=376030

    SET ARKserverPath=%ServerLocation%%ServerOneName%\%ServerOneName%Master
        SET STEAMPATH=%SteamLocation%

%STEAMPATH%\steamcmd.exe +login %STEAMLOGIN% +force_install_dir %ARKserverPath% +"app_update %ARKserverBRANCH%" validate +quit

timeout /t 5 /nobreak > nul

ENDLOCAL ENABLEDELAYEDEXPANSION

timeout /t 5 /nobreak > nul
:: _________________________________________________________
:: Update Server Two
SETLOCAL ENABLEDELAYEDEXPANSION

    SET STEAMLOGIN=anonymous
    SET ARKserverBRANCH=376030

    SET ARKserverPath=%ServerLocation%%ServerTwoName%\%ServerTwoName%Master
        SET STEAMPATH=%SteamLocation%

%STEAMPATH%\steamcmd.exe +login %STEAMLOGIN% +force_install_dir %ARKserverPath% +"app_update %ARKserverBRANCH%" validate +quit

timeout /t 5 /nobreak > nul

ENDLOCAL ENABLEDELAYEDEXPANSION

timeout /t 5 /nobreak > nul

@echo off
:: _________________________________________________________
:: Starting Server One and Installing Mods
start "" "%USERPROFILE%\Desktop\Server 1 Start.lnk"

:: Wait Between Server One and Server Two Start
timeout /t 1 /nobreak > NUL

:: Starting Server Two and Installing Mods
start "" "%USERPROFILE%\Desktop\Server 2 Start.lnk"