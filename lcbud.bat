@echo off
:: Sets Defaults
setlocal EnableDelayedExpansion
set ver=v2.2
set lunarver=3.0.5
set "modtargetDirectory=%userprofile%\.weave\mods"
title lcbud %ver%

:: Check for updates
set "githubAPI=https://api.github.com/repos/unethicalteam/lcbud/releases/latest"
for /f "tokens=2 delims=:" %%I in ('curl -s "%githubAPI%" ^| find "tag_name"') do set "latestTag=%%~I"
for %%A in ("!latestTag!") do set "latestTag=%%~A"
:: Trim leading and trailing spaces from both versions
set "ver=!ver: =!"
set "latestTag=!latestTag:~1,-1!"
:: Remove double quotes from GitHub version
set "latestTag=!latestTag:"=!"

if /i "!latestTag!" neq "!ver!" (
    set "githubURL=https://github.com/unethicalteam/lcbud/releases/latest"
    echo.
    echo   lcbud - Lunar Client Batch Utility Downloader: !ver!
    echo   Created by [31munethical[0m
    echo   [36mhttps://discord.gg/vhJ8Dsp9qa[0m
    echo.
    echo   A new version of lcbud: !latestTag! was found on GitHub!
    echo   You can download it from: [36m!githubURL![0m
    echo   Press any key to exit...
    pause >nul
    exit /b
) else (
    :: This creates the weave mod directory if it doesn't exist
    if not exist "!modtargetDirectory!" (
        mkdir "!modtargetDirectory!"
    )
    
    :: This checks for Lunar Client folders and installs Lunar Client if necessary
    if not exist "%localappdata%\programs\launcher\" (
        if not exist "%localappdata%\programs\lunarclient\" (
            cls
            echo.
            echo   lcbud - Lunar Client Batch Utility Downloader: %ver%
            echo   Created by [31munethical[0m
            echo   [36mhttps://discord.gg/vhJ8Dsp9qa[0m
            echo.
            echo    Lunar Client is not installed. Downloading...
            echo    This utility would be useless to you otherwise.
            curl https://launcherupdates.lunarclientcdn.com/Lunar%%20Client%%20v!lunarver!.exe -o "Lunar Client v!lunarver!.exe"
            echo    Press any key to launch the installer...
            pause >nul
            start "" "Lunar Client v!lunarver!.exe"
        ) else (
            goto :menu
        )
    ) else (
        goto :menu
    )
)

:menu
cls
echo.
echo   lcbud - Lunar Client Batch Utility Downloader: %ver%
echo   Created by [31munethical[0m
echo   [36mhttps://discord.gg/vhJ8Dsp9qa[0m
echo.
set "input="
echo   Select an option:
echo.
echo   1) Download Lunar Client QT (Youded's Fork)
echo   2) Download Lunar Client QT 2.0 (Nils)
echo   3) Download Lunar Launcher Inject
echo   4) Download Weave Loader
echo   5) Download Agents / Mods
echo   6) Download JREs
echo   7) Downgrade Lunar Client Launcher to 2.16.1
echo   -------------------------------------------
echo   8) View Credits
echo   9) View License
echo   10) Exit
echo.
set /p "input=Enter the corresponding number and press Enter: "

:: Array for handling download links
set "applicationData[1]=https://github.com/Youded-byte/lunar-client-qt/releases/latest/download/windows.zip lcqt.zip"
set "applicationData[2]=https://github.com/Nilsen84/lcqt2/releases/latest/download/windows-portable.zip lcqt2-nils.zip"
set "applicationData[3]=https://github.com/Nilsen84/lunar-launcher-inject/releases/download/v1.3.0/lunar-launcher-inject-windows-1.3.0.exe lunar-launcher-inject.exe"
set "applicationData[4]=https://github.com/Weave-MC/Weave-Loader/releases/download/v0.2.3/Weave-Loader-Agent-0.2.3.jar Weave-Loader-Agent-0.2.3.jar"

:: Iterate through options and handle downloads
for %%i in (1 2 3 4) do (
    for /f "tokens=1,2" %%a in ("!applicationData[%%i]!") do (
        if "%input%"=="%%i" (
            call :DownloadFile "%%a" "%%b"
            
            :: Handling .zip files
            if "%%b"=="lcqt.zip" (
                mkdir lcqt
                tar -xf "%%b" --directory ./lcqt --strip-components=1
                del "%%b"
            ) else if "%%b"=="lcqt2-nils.zip" (
                mkdir lcqt2-nils
                tar -xf "%%b" --directory ./lcqt2-nils
                del "%%b"
            )
            
            :: Download completed message
            cls
            echo.
            echo   lcbud - Lunar Client Batch Utility Downloader: %ver%
            echo   Created by [31munethical[0m
            echo   [36mhttps://discord.gg/vhJ8Dsp9qa[0m
            echo.
            echo   Download Completed.
            timeout /t 2 > nul
            
            goto :menu
        )
    )
)

:: Handle other menu options
if "%input%"=="5" goto :am
if "%input%"=="6" goto :jres
if "%input%"=="7" goto :lcd
if "%input%"=="8" goto :credits
if "%input%"=="9" goto :license
if "%input%"=="10" exit /b
goto :menu

:am
set "am="
cls
echo.
echo   lcbud - Lunar Client Batch Utility Downloader: %ver%
echo   Created by [31munethical[0m
echo   [36mhttps://discord.gg/vhJ8Dsp9qa[0m
echo.
echo   What would you like to do?
echo.
echo   1) Download Agents
echo   2) Download Mods
echo   3) Go Back
echo.
set /p am="Select an option: "

if "%am%"=="1" goto :agents
if "%am%"=="2" goto :mods
if "%am%"=="3" goto :menu

:agents
set "agents="
cls
echo.
echo   lcbud - Lunar Client Batch Utility Downloader: %ver%
echo   Created by [31munethical[0m
echo   [36mhttps://discord.gg/vhJ8Dsp9qa[0m
echo.
echo   Agents:
echo   1) CrackedAccount (Not Needed for LCQT2)
echo   2) CustomAutoGG
echo   3) CustomLevelHead
echo   4) HitDelayFix (Not Needed for LCQT2)
echo   5) LevelHeadNicks
echo   6) LunarEnable (Not Needed for LCQT2)
echo   7) LunarPacksFix (Not Needed for LCQT2)
echo   8) NoPinnedServers
echo   9) RemovePlus
echo  10) StaffEnable (Not Needed for LCQT2)
echo  11) TeamsAutoGG
echo  12) Go Back
echo.
set /p "agents=Select an option: "

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

if defined agentoutputPath (
    set "folderSelection=Selected folder: !agentoutputPath!"
) else (
    set "folderSelection=No folder selected."
)

for /L %%i in (1,1,11) do (
    if /i "%agents%"=="%%i" (
        set "url=https://github.com/Nilsen84/lunar-client-agents/releases/latest/download/!agentData[%%i]!.jar"
        set "output=!agentData[%%i]!.jar"
        :: Verify if the selected folder exists
        if not exist "!agentoutputPath!\" (
            echo The selected folder does not exist.
            set "agentoutputPath="
        )
        :agentPicker
        if not defined agentoutputPath (
            echo %folderSelection%
            echo Opening folder picker...
            for /f %%I in ('cscript //nologo FolderPicker.vbs') do set "agentoutputPath=%%~I"
        )
        if not defined agentoutputPath (
            echo No folder selected.
            timeout /t 2 > nul
            goto :agents
        ) else (
            call :DownloadFile "!url!" "!agentoutputPath!\!output!"
        )
        
        goto :agents
    )
)

if "%agents%"=="12" goto :am
goto :agents

:mods
set "mods="
cls
echo.
echo   lcbud - Lunar Client Batch Utility Downloader: %ver%
echo   Created by [31munethical[0m
echo   [36mhttps://discord.gg/vhJ8Dsp9qa[0m
echo.
echo   Mods:
echo   1) Alex Fix - Fixes a bug where Alex's arms are shifted down lower than Steve's.
echo   2) Blood Kill Effect - Redstone particles when a player dies.
echo   3) Cracked Account - Sail the high seas with a poor person's account.
echo   4) Crepes - Display MinecraftCapes users' capes in-game. (ZenithCore Required)
echo   5) Dulikk - Custom View Model
echo   6) FPS - Set a custom FPS limit.
echo   7) FPS Spoofer - Spoof your FPS.
echo   8) Good Game - AutoGG for more servers.
echo   9) GTB Solver - Guess the builder solver.
echo  10) Hu Tao - Draw a dancing Hu Tao on your screen.
echo  11) Inclumsy - Spoof your ping.
echo  12) JumpReset - Automatically jump resets for you.
echo  13) KeyboardFix - Fix for Linux users where "Shift-2" and "Shift-6" key combinations don't work.
echo  14) MMUtils - Hypixel Murder Mystery Utilities.
echo  15) Name History - Check a user's name history with a command.
echo  16) OofMod - Play a customizable sound during in-game events.
echo  17) PitUtils - Hypixel Pit Utilities.
echo  18) Raw Input
echo  19) Toggle Bobbing - Quickly toggle view bobbing.
echo  20. Toggle Chat (ZenithCore Required)
echo  21) VanillaMenu - Bring back the vanilla Minecraft main menu.
echo  22) ViaLunar - Join 1.9+ servers from LunarClient 1.8 (ZenithCore Required)
echo  23) Weave Optifine URL - Specify a new URL for the Optifine cape server.
echo  24) ZenithCore - Dependency for mods.
echo   -------------------------------------------
echo  25) Cheats
echo  26) Go Back
echo.
set /p mods="Select an option: "

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
goto :mods

:modscheats
set "modscheats="
cls
echo.
echo   lcbud - Lunar Client Batch Utility Downloader: %ver%
echo   Created by [31munethical[0m
echo   [36mhttps://discord.gg/vhJ8Dsp9qa[0m
echo.
echo   Cheats:
echo   1) Blue Client [40;31m(Cheating Client)[40;37m
echo   2) Fractal [40;31m(Cheating Client)[40;37m
echo   3) Legit-ish [40;31m(Cheating Client)[40;37m
echo   4) NoHitDelay
echo   5) RavenWeave [40;31m(Cheating Client[40;37m, ZenithCore Required)
echo   6) RavenWeaveLite [40;31m(Cheating Client)[40;37m
echo   7) VapeFix
echo   8) Go Back
echo.
set /p modscheats="Select an option: "

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
goto :modscheats

:jres
set "jres="
cls
echo.
echo   lcbud - Lunar Client Batch Utility Downloader: %ver%
echo   Created by [31munethical[0m
echo   [36mhttps://discord.gg/vhJ8Dsp9qa[0m
echo.
echo   JREs:
echo   1) GraalVM
echo   2) Go Back
echo.
set /p jres="Select an option: "

if "%jres%"=="1" goto :graalvmdownloader
if "%jres%"=="2" goto :menu

:graalvmdownloader
cls
echo.
echo   lcbud - Lunar Client Batch Utility Downloader: %ver%
echo   Created by [31munethical[0m
echo   [36mhttps://discord.gg/vhJ8Dsp9qa[0m
echo.
echo    1) GraalVM Java 20
echo    2) GraalVM Java 17
echo    3) Go Back
echo.
set /p selection="Select an option: "

set "javaVersion="
if "%selection%"=="1" (
    set "javaVersion=20"
) else if "%selection%"=="2" (
    set "javaVersion=17"
) else if "%selection%"=="3" (
    goto :jres
) else (
    goto :graalvmdownloader
)

echo Opening folder picker...
for /f %%I in ('cscript //nologo FolderPicker.vbs') do set "outputPath=%%~I"

if not defined outputPath (
    echo No folder selected.
    goto :graalvmdownloader
)

set "graalFolderName=graalvm-jdk%javaVersion%-%javaVersion%"
set "folder=%outputPath%\%graalFolderName%"
set "zip=%graalFolderName%.zip"
set "downloadUrl=https://download.oracle.com/graalvm/%javaVersion%/latest/graalvm-jdk-%javaVersion%_windows-x64_bin.zip"

if not exist "%zip%" (
    echo Downloading GraalVM from %downloadUrl%
    call :DownloadFile "%downloadUrl%" "%zip%"
    if errorlevel 1 (
        echo Failed to download GraalVM!
        exit /b 1
    )
)

echo Extracting GraalVM to the specified folder...
mkdir "%folder%"
tar -xzf "%zip%" -C "%folder%" --strip-components=1

echo Cleaning up...
del "%zip%" > nul 2>&1

echo Completed!
timeout /t 2 > nul
goto :jres

:lcd
cls
echo.
echo   lcbud - Lunar Client Batch Utility Downloader: %ver%
echo   Created by [31munethical[0m
echo   [36mhttps://discord.gg/vhJ8Dsp9qa[0m
echo.
echo   [40;31mDowngrading will download the Lunar Client 2.16.1 Launcher files and delete 3.0.x.
echo   Are you sure you want to continue?[40;37m
echo   -------------------------------------------
echo   Type 'Yes' to continue or type 'back' to go back.
echo.
set /p "dg="

if /i "%dg%"=="Yes" (
    cls
    echo.
    echo   lcbud - Lunar Client Batch Utility Downloader: %ver%
    echo   Created by [31munethical[0m
    echo   [36mhttps://discord.gg/vhJ8Dsp9qa[0m
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
echo   lcbud - Lunar Client Batch Utility Downloader: %ver%
echo   Created by [31munethical[0m
echo   [36mhttps://discord.gg/vhJ8Dsp9qa[0m
echo.
echo   Lunar Client QTs:
echo     Youded-Byte (QT) - [36mhttps://github.com/Youded-byte/lunar-client-qt[0m
echo     Nilsen84 (QT 2.0) - [36mhttps://github.com/Nilsen84/lcqt2[0m
echo.
echo   Lunar Client Launcher Inject:
echo     Nilsen84 - [36mhttps://github.com/Nilsen84/lunar-launcher-inject[0m
echo.
echo   Weave Loader:
echo     Weave Maintainers - [36mhttps://github.com/Weave-MC[0m
echo.
echo   Agents:
echo     Nilsen84 - [36mhttps://github.com/Nilsen84/[0m
echo.
echo   Press any key to go back...
pause >nul
goto :menu

:license
cls
echo.
echo   lcbud - Lunar Client Batch Utility Downloader: %ver%
echo   Created by [31munethical[0m
echo   [36mhttps://discord.gg/vhJ8Dsp9qa[0m
echo.
echo   lcbud Copyright (C) 2023 unethicalmc
echo   This program comes with ABSOLUTELY NO WARRANTY.
echo   This is free software, and you are welcome to redistribute it
echo   under certain conditions; type `license` to view the license in a browser.
echo.
echo   lcbud is licensed under LGPLv3 and version 3 only.
echo   -------------------------------------------
echo   Type `back` to go back.
echo.
set /p "details=lcbud.bat: "

if /i "%details%"=="license" (
    cls
    echo   Opening license in browser...
    start https://choosealicense.com/licenses/lgpl-3.0/
    echo   Press any key to continue...
    pause >nul
)

if /i "%details%"=="back" (
    goto :menu
)
goto :license

:: Handles downloading files via cURL
:DownloadFile
cls
echo.
echo   lcbud - Lunar Client Batch Utility Downloader: %ver%
echo   Created by [31munethical[0m
echo   [36mhttps://discord.gg/vhJ8Dsp9qa[0m
echo.
set "url=%~1"
set "output=%~2"
curl -L "%url%" > "!output!.tmp" 
if !errorlevel! neq 0 (
    cls
    echo.
    echo   lcbud - Lunar Client Batch Utility Downloader: %ver%
    echo   Created by [31munethical[0m
    echo   [36mhttps://discord.gg/vhJ8Dsp9qa[0m
    echo.
    echo Error downloading "!output!".
    echo.
    timeout /t 2 > nul
    del "!output!.tmp" 2>nul
)
move /y "!output!.tmp" "!output!"
goto :eof