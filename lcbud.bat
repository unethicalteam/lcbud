@echo off
set ver=v2.0
setlocal EnableDelayedExpansion

:setDefaults
set "modtargetDirectory=%userprofile%\.weave\mods"

rem Create the mod directory if it doesn't exist
if not exist "!modtargetDirectory!" (
    mkdir "!modtargetDirectory!"
)

title lcbud %ver%

if not exist "%localappdata%\programs\launcher\" (
    cls
    echo.
    echo lcbud - Lunar Client Batch Utility Downloader: %ver%
    echo.
    echo Lunar Client is not installed. Downloading...
    echo This utility would be useless to you otherwise.
    curl https://launcherupdates.lunarclientcdn.com/Lunar%%20Client%%20v3.0.4.exe -o "Lunar Client v3.0.4.exe"
    echo Press any key to launch the installer...
    pause >nul
    start "" "Lunar Client v3.0.4.exe"
    goto :menu
)

:menu
cls
echo.
echo lcbud - Lunar Client Batch Utility Downloader: %ver%
echo.
set "input="
echo 1. Download Lunar Client QT (Youded's Fork)
echo 2. Download Lunar Client QT 2.0 (Nils)
echo 3. Download Lunar Launcher Inject
echo 4. Download Weave Loader
echo -------------------------------------------
echo 5. Download Agents / Mods
echo 6. Downgrade Lunar Client Launcher to 2.16.1
echo 7. Credits
echo 8. License
echo 9. Exit
echo.
set /p "input=Enter Corresponding Number and Hit Enter: "

set "applicationData[1]=https://github.com/Youded-byte/lunar-client-qt/releases/latest/download/windows.zip lcqt.zip"
set "applicationData[2]=https://github.com/Nilsen84/lcqt2/releases/latest/download/windows-portable.zip lcqt2-nils.zip"
set "applicationData[3]=https://github.com/Nilsen84/lunar-launcher-inject/releases/download/v1.3.0/lunar-launcher-inject-windows-1.3.0.exe lunar-launcher-inject.exe"
set "applicationData[4]=https://github.com/Weave-MC/Weave-Loader/releases/download/v0.2.3/Weave-Loader-Agent-0.2.3.jar Weave-Loader-Agent-0.2.3.jar"

for %%i in (1 2 3 4) do (
    for /f "tokens=1,2" %%a in ("!applicationData[%%i]!") do (
        if "%input%"=="%%i" (
            call :DownloadFile "%%a" "%%b"
            
            rem Handling .zip files
            if "%%b"=="lcqt.zip" (
                mkdir lcqt
                tar -xf "%%b" --directory ./lcqt
                del "%%b"
            ) else if "%%b"=="lcqt2-nils.zip" (
                mkdir lcqt2-nils
                tar -xf "%%b" --directory ./lcqt2-nils
                del "%%b"
            )
            
            goto :downloadCompleted
        )
    )
)

if "%input%"=="5" goto :am
if "%input%"=="6" goto :lcd
if "%input%"=="7" goto :credits
if "%input%"=="8" goto :license
if "%input%"=="9" exit /b
goto :menu

:downloadCompleted
cls
echo.
echo lcbud - Lunar Client Batch Utility Downloader: %ver%
echo.
echo Download(s) Completed.
pause
goto :menu

:am
set "am="
cls
echo.
echo lcbud - Lunar Client Batch Utility Downloader: %ver%
echo.
echo 1. Agents
echo 2. Mods
echo -------------------------------------------
echo 3. Back
echo 4. Exit
echo.
set /p am="Enter Corresponding Number and Hit Enter: "

if "%am%"=="1" goto :agents
if "%am%"=="2" goto :mods
if "%am%"=="3" goto :menu
if "%am%"=="4" exit /b 

:agents
set "agents="
cls
echo.
echo lcbud - Lunar Client Batch Utility Downloader: %ver%
echo.
echo Agents:
echo  1. CrackedAccount (Not Needed for LCQT2)
echo  2. CustomAutoGG
echo  3. CustomLevelHead
echo  4. HitDelayFix (Not Needed for LCQT2)
echo  5. LevelHeadNicks
echo  6. LunarEnable (Not Needed for LCQT2)
echo  7. LunarPacksFix (Not Needed for LCQT2)
echo  8. NoPinnedServers
echo  9. RemovePlus
echo 10. StaffEnable (Not Needed for LCQT2)
echo 11. TeamsAutoGG
echo -------------------------------------------
echo 12. Back
echo 13. Exit
echo.
set /p "agents=Which would you like to download?: "

set "agentData[1]=CrackedAccount"
set "agentData[2]=CustomAutoGG"
set "agentData[3]=CustomLevelHead"
set "agentData[4]=HitDelayFix"
set "agentData[5]=LevelHeadNicks"
set "agentData[6]=LunarEnable"
set "agentData[7]=LunarPacksFix"
set "agentData[8]=NoPinnedServers"
set "agentData[9]=RemovePlus"
set "agentData[10]=StaffEnable"
set "agentData[11]=TeamsAutoGG"

for /L %%i in (1,1,11) do (
    if /i "%agents%"=="%%i" (
        set "url=https://github.com/Nilsen84/lunar-client-agents/releases/latest/download/!agentData[%%i]!.jar"
        set "output=!agentData[%%i]!.jar"
        call :DownloadFile !url! !output!
        goto :agents
    )
)
if "%agents%"=="12" goto :am
if "%agents%"=="13" goto :eof
goto :agents

:mods
set "mods="
cls
echo.
echo lcbud - Lunar Client Batch Utility Downloader: %ver%
echo.
echo Mods:
echo 1. Alex Fix - Fixes a bug where Alex's arms are shifted down lower than Steve's.
echo 2. Blood Kill Effect - Redstone particles when a player dies.
echo 3. Cracked Account - Sail the high seas poor person.
echo 4. Crepes - MinecraftCapes users' capes in-game. (ZenithCore Required)
echo 5. Dulikk - Custom View Model
echo 6. FPS - Set a custom FPS limit.
echo 7. FPS Spoofer - Spoof your FPS.
echo 8. Good Game - AutoGG for more servers.
echo 9. GTB Solver - Guess the builder solver.
echo 10. Hu Tao - Draw a dancing Hu Tao on your screen.
echo 11. Inclumsy - Spoof your ping.
echo 12. JumpReset - Automatically jump resets for you.
echo 13. KeyboardFix - A fix for Linux users where "Shift-2" and "Shift-6" key combinations aren't working.
echo 14. MMUtils - Hypixel Murder Mystery Utilities.
echo 15. Name History - Check a users name history with a command.
echo 16. OofMod - Play a customizable sound during events in-game.
echo 17. PitUtils - Hypixel Pit Utilities.
echo 18. Raw Input
echo 19. Toggle Bobbing - Quickly toggle view bobbing.
echo 20. Toggle Chat (ZenithCore Required)
echo 21. VanillaMenu -  Bring back the vanilla Minecraft main menu
echo 22. ViaLunar - Joining 1.9+ servers from LunarClient 1.8 (ZenithCore Required)
echo 23. Weave Optifine URL - Specifiy a new URL for the Optifine cape server
echo 24. ZenithCore - Dependency for mods
echo -------------------------------------------
echo 25. Cheats
echo 26. Back
echo 27. Exit
echo.
set /p mods="Which would you like to download?: "

set "modData[1]=https://github.com/Zircta/AlexFix/releases/download/1.1/AlexFix-1.1.jar AlexFix.jar"
set "modData[2]=https://github.com/Zircta/BloodKillEffect/releases/download/1.1/BloodKillEffect-1.1.jar BloodKillEffect.jar"
set "modData[3]=https://gitlab.com/candicey-weave/cracked-account/uploads/c351fccaba7d5aabc6746bff63137ba6/WeaveCrackedAccount-0.2.1.jar WeaveCrackedAccount.jar"
set "modData[4]=https://gitlab.com/candicey-weave/crepes/uploads/94b6d61337cc03c8e55745cce5845bce/Crepes-0.1.1.jar Crepes.jar"
set "modData[5]=https://gitlab.com/candicey-weave/dulikk/uploads/2f0c733b0ab6fa1ccd644c80b0c07eb1/Dulikk-0.1.0.jar Dulikk.jar"
set "modData[6]=https://github.com/Zircta/FPS/releases/download/2.0/FPS-2.0.jar FPS.jar"
set "modData[7]=https://github.com/AriaJackie/FPS-Spoofer/releases/download/release-2.0/fpsspoofer-1.1.jar fpsspoofer.jar"
set "modData[8]=https://github.com/Zircta/GG/releases/download/3.0/GG-3.0.jar GG.jar"
set "modData[9]=https://gitlab.com/candicey-weave/gtb-solver/uploads/d1288dbce390dbe7d98cfc1f406750fd/GTB-Solver-0.1.0.jar GTB-Solver.jar"
set "modData[10]=https://github.com/Ultramicroscope/HuTao/releases/download/v1.1/HuTao-1.0.jar HuTao.jar"
set "modData[11]=https://codeberg.org/Candicey-Weave/Inclumsy/releases/download/v0.1.0/Inclumsy-0.1.0.jar Inclumsy.jar"
set "modData[12]=https://github.com/Zircta/JumpReset/releases/download/1.0/JumpReset-1.0.jar JumpReset.jar"
set "modData[13]=https://github.com/Leo3418/mckeyboardfix/releases/download/v1.0/mckeyboardfix-1.0.jar mckeyboardfix.jar"
set "modData[14]=https://github.com/Yan-Jobs/mm-utils/releases/download/v1/MMUtils-1.0.jar MMUtils.jar"
set "modData[15]=https://github.com/Ultramicroscope/NameHistory/releases/download/weave-1.0/NameHistory-1.0.jar NameHistory.jar"
set "modData[16]=https://github.com/thaYt/oofmod/releases/download/v1.0/OofMod-1.0.jar OofMod.jar"
set "modData[17]=https://github.com/supercoolspy/PitUtilsLunar/releases/download/1.1.0/PitUtils-1.1.0.jar PitUtils.jar"
set "modData[18]=https://github.com/koxx12-dev/Weave-Raw-Input/releases/download/1.0.1/RawInput-1.0.1.jar RawInput.jar"
set "modData[19]=https://github.com/Zircta/Toggle-Bobbing/releases/download/1.0/ToggleBobbing-1.0.jar ToggleBobbing.jar"
set "modData[20]=https://github.com/Zircta/ToggleChat/releases/download/1.2/ToggleChat-1.2.jar ToggleChat.jar"
set "modData[21]=https://github.com/Zxnii/VanillaMenu/releases/download/v3.0.0/VanillaMenu-3.0.0.jar VanillaMenu.jar"
set "modData[22]=https://gitlab.com/candicey-weave/viaversion-lunar/uploads/9ba371b7abc07e0958ec559a9d9f0a30/ViaLunar-3.0.0.jar ViaLunar.jar"
set "modData[23]=https://github.com/770grappenmaker/weave-optifine-url/releases/download/v0.1/weave-optifine-url-0.1.jar weave-optifine-url.jar"
set "modData[24]=https://codeberg.org/Candicey-Weave/Zenith-Core/releases/download/v1.3.7/Zenith-Core-1.3.7.jar Zenith-Core.jar"

for %%i in (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24) do (
    for /f "tokens=1,2" %%a in ("!modData[%%i]!") do (
        if "%mods%"=="%%i" (
            call :DownloadFile "%%a" "%%b"
            move "%%b" "!modtargetDirectory!\%%b" > nul
            goto :mods
        )
    )
)

if /i "%mods%"=="25" goto :modscheats
if /i "%mods%"=="26" goto :am
if /i "%mods%"=="27" goto :eof
:: rem Disabled Mod Downloads
:: if /i "%mods%"=="X" goto :errorDisabledModDownload
goto :mods

:modscheats
set "modscheats="
cls
echo.
echo lcbud - Lunar Client Batch Utility Downloader: %ver%
echo.
echo Cheats:
echo 1. Blue Client [40;31m(Cheating Client)
echo [40;37m2. Fractal [40;31m(Cheating Client)
echo [40;37m3. Legit-ish [40;31m(Cheating Client)
echo [40;37m4. NoHitDelay
echo 5. RavenWeave [40;31m(Cheating Client[40;37m, ZenithCore Required)
echo 6. RavenWeaveLite [40;31m(Cheating Client)
echo [40;37m7. VapeFix
echo -------------------------------------------
echo 8. Back
echo 9. Exit
echo.
set /p modscheats="Which would you like to download?: "

set "cheatData[1]=https://github.com/kacorvixon1337/blueclient/releases/download/release/blue-client.jar BlueClient"
set "cheatData[2]=https://github.com/AriaJackie/Fractal/releases/download/release-1.2/fractal-weave-1.2.jar Fractal"
set "cheatData[3]=https://github.com/legitish/Legit-ish-Weave/releases/download/v2.0.0-beta/legitish-2.0.0-beta.jar Legit-ish"
set "cheatData[4]=https://github.com/Nilsen84/WeaveNoHitDelay/releases/download/v2.0/WeaveNoHitDelay-2.0.jar NoHitDelay"
set "cheatData[5]=https://github.com/PianoPenguin471/RavenWeave/releases/download/1.1.3/RavenWeave-1.1.3.jar RavenWeave"
set "cheatData[6]=https://github.com/PianoPenguin471/RavenWeaveLite/releases/download/bugfix/RavenWeaveLite-1.0.jar RavenWeaveLite"
set "cheatData[7]=https://github.com/Zircta/VapeFix/releases/download/2.0/VapeFix-2.0.jar VapeFix"

for %%i in (1 2 3 4 5 6 7) do (
    for /f "tokens=1,2" %%a in ("!cheatData[%%i]!") do (
        if "%modscheats%"=="%%i" (
            call :DownloadFile "%%a" "%%b.jar"
            if !errorlevel! neq 0 (
                echo Error downloading %%b.jar.
            ) else (
                move "%%b.jar" "!modtargetDirectory!\%%b.jar" > nul
            )
            goto :modscheats
        )
    )
)
if "%modscheats%"=="8" goto :mods
if "%modscheats%"=="9" goto :eof
goto :modscheats

:lcd
cls
echo.
echo lcbud - Lunar Client Batch Utility Downloader: %ver%
echo.
echo [40;31mDowngrading will download the Lunar Client 2.16.1 Launcher files and delete 3.0.x.
echo Are you sure you want to continue?
echo [40;37m-------------------------------------------
echo Type 'Yes' to continue or type 'back' to go back.
echo.
set /p "dg="

if /i "%dg%"=="Yes" (
    cls
    echo.
    echo lcbud - Lunar Client Batch Utility Downloader: %ver%
    echo.
    echo [40;31mFinal warning, this will delete 3.0.x.
    echo unethical is not liable for any damages done to your system.
    echo Please only use this if you know what you're doing.
    echo [40;37mYou can quit by pressing Alt+F4 or...
    echo Press any key to continue...
    pause >nul

    call :DownloadFile "https://cdn.discordapp.com/attachments/1140173680018735144/1140453928056672358/Lunar_Client_v2.16.1.zip" "LCL.zip"
    
    mkdir lcl
    tar -xf lcl.zip --directory ./lcl
    del LCL.zip
    
    rmdir /S /Q %localappdata%\programs\launcher >nul
    xcopy /e /i /v lcl\launcher %localappdata%\programs\launcher\
    echo Launcher files copied successfully.
    
    rmdir /S /Q lcl >nul
    echo Temporary files removed.
    echo Press any key to continue...
    pause >nul
)
if /i "%dg%"=="back" (
    goto :menu
)
goto :lcd

:credits
cls
echo.
echo lcbud - Lunar Client Batch Utility Downloader: %ver%
echo.
echo maintainers - unethicalmc
echo lunar client qt - Youded-Byte
echo lunar client qt 2.0 - Nilsen84
echo lunar client launcher inject - Nilsen84
echo Weave Loader - Weave Maintainers
echo agents - Nilsen84
echo.
echo Press any key to go back...
pause >nul
goto :menu

:license
cls
echo.
echo lcbud - Lunar Client Batch Utility Downloader: %ver%
echo.
echo lcbud  Copyright (C) 2023 unethicalmc
echo This program comes with ABSOLUTELY NO WARRANTY.
echo This is free software, and you are welcome to redistribute it
echo under certain conditions; type `license` to view the license in a browser.
echo.
echo lcbud is licensed under LGPLv3 and version 3 only.
echo -------------------------------------------
echo Type `back` to go back.
echo.
set /p "details=lcbud.bat: "

if /i "%details%"=="license" (
    cls
    echo Opening license in browser...
    start https://choosealicense.com/licenses/lgpl-3.0/
    echo Press any key to continue...
    pause >nul
)

if /i "%details%"=="back" (
    goto :menu
)
goto :license

rem DownloadFile subroutine
:DownloadFile
cls
echo.
echo lcbud - Lunar Client Batch Utility Downloader: %ver%
echo.
set "url=%~1"
set "output=%~2"
curl -L "%url%" > "%output%.tmp" 
if %errorlevel% neq 0 (
    cls
    echo.
    echo lcbud - Lunar Client Batch Utility Downloader: %ver%
    echo.
    echo Error downloading %~2.
    echo.
    echo Press any key to go back...
    pause > nul
    del "%output%.tmp" 2>nul
    goto :eof
)
ren "%output%.tmp" "%output%"
goto :eof

rem Errors (Unused Currently)
:errorDisabledAgentDownload
cls
echo.
echo lcbud - Lunar Client Batch Utility Downloader: %ver%
echo.
echo [40;31mError: [40;37mThis agent download is temporarily disabled.
echo Wait for an update! Sorry for the inconvenience.
echo.
pause
goto :agents

:errorDisabledModDownload
cls
echo.
echo lcbud - Lunar Client Batch Utility Downloader: %ver%
echo.
echo [40;31mError: [40;37mThis mod download is temporarily disabled.
echo Wait for an update! Sorry for the inconvenience.
echo.
pause
goto :mods
