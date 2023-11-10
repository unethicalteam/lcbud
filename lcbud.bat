@echo off
setlocal EnableDelayedExpansion
set ver=v2.5.1
set "modtargetDirectory=%userprofile%\.weave\mods"
set "githubAPI=https://api.github.com/repos/unethicalteam/lcbud/releases/latest"
set "githubURL=https://github.com/unethicalteam/lcbud/releases/latest"
title lcbud %ver%

if not exist "picker.exe" (
    curl -L -s https://github.com/unethicalteam/picker-go/releases/latest/download/picker.exe -o picker.exe
)

for /f "tokens=2 delims=: " %%a in ('curl -s https://launcherupdates.lunarclientcdn.com/latest.yml ^| findstr "version:"') do (
    set "lunarver=%%a"
)

for /f "tokens=2 delims=:" %%I in ('curl -s "%githubAPI%" ^| find "tag_name"') do set "latestTag=%%~I"
set "latestTag=!latestTag:~1,-1!"
set "latestTag=!latestTag:"=!"
if /i "!latestTag!" neq "!ver!" (
    call :Header
    echo   A new version of lcbud: !latestTag! was found on GitHub!
    echo   You can download it from: [36m!githubURL![0m
    echo   Press any key to exit...
    pause >nul
    exit /b
) else (
    if not exist "!modtargetDirectory!" (
        mkdir "!modtargetDirectory!"
    )
    
    if not exist "%localappdata%\programs\launcher\" (
        if not exist "%localappdata%\programs\lunarclient\" (
            call :Header
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

:Header
cls
echo.
echo   lcbud - Lunar Client Batch Utility Downloader: %ver%
echo   Created by [31munethical[0m
echo   [36mhttps://unethical.team/discord[0m
echo.
goto :eof

:menu
call :Header
set "input="
echo   Select an option:
echo.
echo   1) Download Lunar Client QT (Youded's Fork)
echo   2) Download Lunar Client QT 2.0 (Nils)
echo   3) Download Lunar Launcher Inject
echo   4) Download Weave Loader
echo   5) Download Agents / Mods
echo   6) Download Utilities
echo   7) Download JREs
echo   8) Downgrade Lunar Client Launcher to 2.16.1
echo   9) Backup multiver
echo   -------------------------------------------
echo  10) View Credits
echo  11) View License
echo  12) Exit
echo.
set /p "input=Enter the corresponding number and press Enter: "

set "applicationData[1]=https://github.com/Youded-byte/lunar-client-qt/releases/latest/download/windows.zip lcqt.zip"
set "applicationData[2]=https://unethicalcdn.com/lcqt2/windows-portable.zip lcqt2-nils.zip"
set "applicationData[3]=https://github.com/Nilsen84/lunar-launcher-inject/releases/download/v1.3.0/lunar-launcher-inject-windows-1.3.0.exe lunar-launcher-inject.exe"
set "applicationData[4]=https://github.com/Weave-MC/Weave-Loader/releases/download/v0.2.4/Weave-Loader-Agent-0.2.4.jar Weave-Loader-Agent-0.2.4.jar"

for %%i in (1 2 3 4) do (
    for /f "tokens=1,2" %%a in ("!applicationData[%%i]!") do (
        if "%input%"=="%%i" (
            call :DownloadFile "%%a" "%%b"
            
            if "%%b"=="lcqt.zip" (
                mkdir lcqt
                tar -xf "%%b" --directory ./lcqt --strip-components=1
                del "%%b"
            ) else if "%%b"=="lcqt2-nils.zip" (
                mkdir lcqt2-nils
                tar -xf "%%b" --directory ./lcqt2-nils
                del "%%b"
            )
            
            call :Header
            echo   Download Completed.
            timeout /t 2 > nul
            
            goto :menu
        )
    )
)

if "%input%"=="5" goto :am
if "%input%"=="6" goto :utilities
if "%input%"=="7" goto :jres
if "%input%"=="8" goto :lcd
if "%input%"=="9" goto :multiver
if "%input%"=="10" goto :credits
if "%input%"=="11" goto :licenses
if "%input%"=="12" exit /b
goto :menu

:am
set "am="
call :Header
echo   What would you like to do?
echo.
echo   1) Download Agents
echo   2) Download Mods
echo   -------------------------------------------
echo   3) Go Back
echo.
set /p am="Select an option: "

if "%am%"=="1" goto :agents
if "%am%"=="2" goto :mods
if "%am%"=="3" goto :menu

:agents
set "agents="
call :Header
echo   Agents:
echo   1) CrackedAccount (Not Needed for LCQT2)
echo   2) CustomAutoGG
echo   3) CustomLevelHead
echo   4) HitDelayFix (Not Needed for LCQT2)
echo   5) LevelHeadNicks
echo   6) LunarAntiPollingRateCheck
echo   7) LunarEnable (Not Needed for LCQT2)
echo   8) LunarPacksFix (Not Needed for LCQT2)
echo   9) NoPinnedServers
echo  10) RemovePlus
echo  11) StaffEnable (Not Needed for LCQT2)
echo  12) TeamsAutoGG
echo   -------------------------------------------
echo  13) Go Back
echo.
set /p "agents=Select an option: "

set "agentData[1]=CrackedAccount"
set "agentData[2]=CustomAutoGG"
set "agentData[3]=CustomLevelHead"
set "agentData[4]=HitDelayFix"
set "agentData[5]=LevelHeadNicks"
set "agentData[6]=LunarAntiPollingRateCheck"
set "agentData[7]=LunarEnable"
set "agentData[8]=LunarPacksFix"
set "agentData[9]=NoPinnedServers"
set "agentData[10]=RemovePlus"
set "agentData[11]=StaffEnable"
set "agentData[12]=TeamsAutoGG"

if defined agentoutputPath (
    set "folderSelection=Selected folder: !agentoutputPath!"
) else (
    set "folderSelection=No folder selected."
)

for /L %%i in (1,1,12) do (
    if /i "%agents%"=="%%i" (
        if "%%i"=="6" (
            set "url=https://github.com/Youded-byte/LunarAntiPollingRateCheck/releases/latest/download/LunarAntiPollingRateCheck.jar"
        ) else (
            set "url=https://github.com/Nilsen84/lunar-client-agents/releases/latest/download/!agentData[%%i]!.jar"
        )
        set "output=!agentData[%%i]!.jar"

        :agentPicker
        cls
        for /f "delims=" %%I in ('picker.exe folder 2^>^&1') do (
            set "pickerOutput=%%I"
        )

        set "pickerErrorLevel=!errorlevel!"

        for /f "tokens=*" %%A in ("!pickerOutput:Operation cancelled by the user.=!") do set "folderPath=%%A"
            if "!folderPath!"=="" (
                echo No folder selected. Please select a folder.
                pause
                goto :agents
            ) else (
                call :DownloadFile "!url!" "!folderPath!\!output!"
            )
        )
    )
)

if "%agents%"=="13" goto :am
goto :agents

:mods
set "mods="
call :Header
echo   Mods:
echo   1) AutoCorrect - Helps you correct your spelling and grammar mistakes.
echo   2) Blurer - A mod that gives you smoooooth blur effects.
echo   3) Cracked Account - Sail the high seas with a poor person's account.
echo   4) Crepes - Display MinecraftCapes users' capes in-game. (ZenithCore Required)
echo   5) Dulikk - Custom View Model
echo   6) GTB Solver - Guess the builder solver.
echo   7) Hu Tao - Draw a dancing Hu Tao on your screen.
echo   8) Inclumsy - Spoof your ping.
echo   9) InventorySnow - snow in your inventory
echo  10) MMUtils - Hypixel Murder Mystery Utilities.
echo  11) Name History - Check a user's name history with a command.
echo  12) OofMod - Play a customizable sound during in-game events.
echo  13) OuchMod - A Weave Mod for Lunar Client that says "ouch" in chat every time you take damage.
echo  14) PitUtils - Hypixel Pit Utilities.
echo  15) Raw Input (Not Needed for LCQT2)
echo  16) VanillaMenu - Bring back the vanilla Minecraft main menu.
echo  17) ViaLunar - Join 1.9+ servers from LunarClient 1.8 (ZenithCore Required)
echo  18) WeaveChamsMod - Render players over blocks, see players through walls!
echo  19) Weave Optifine URL - Specify a new URL for the Optifine cape server.
echo  20) WeaveQuickReport - quickreport mod rewritten for Weave. Also comes with autododge.
echo  21) WPK - A Weave mod implementation of MPKMod 2 mod.
echo  22) ZenithCore - Dependency for mods.
echo   -------------------------------------------
echo  23) Cheats
echo  24) Go Back
echo.
set /p mods="Select an option: "

set "modData[1]=https://gitlab.com/candicey-weave/autocorrect/-/package_files/96942525/download AutoCorrect.jar"
set "modData[2]=https://gitlab.com/candicey-weave/blurer/-/package_files/96402669/download Blurer.jar"
set "modData[3]=https://gitlab.com/candicey-weave/cracked-account/uploads/c351fccaba7d5aabc6746bff63137ba6/WeaveCrackedAccount-0.2.1.jar WeaveCrackedAccount.jar"
set "modData[4]=https://gitlab.com/candicey-weave/crepes/uploads/94b6d61337cc03c8e55745cce5845bce/Crepes-0.1.1.jar Crepes.jar"
set "modData[5]=https://gitlab.com/candicey-weave/dulikk/uploads/2f0c733b0ab6fa1ccd644c80b0c07eb1/Dulikk-0.1.0.jar Dulikk.jar"
set "modData[6]=https://gitlab.com/candicey-weave/gtb-solver/uploads/d1288dbce390dbe7d98cfc1f406750fd/GTB-Solver-0.1.0.jar GTB-Solver.jar"
set "modData[7]=https://github.com/Ultramicroscope/HuTao/releases/download/v1.1/HuTao-1.0.jar HuTao.jar"
set "modData[8]=https://codeberg.org/Candicey-Weave/Inclumsy/releases/download/v0.1.0/Inclumsy-0.1.0.jar Inclumsy.jar"
set "modData[9]=https://github.com/Tryflle/InventorySnow/releases/download/1.1-Compatibility-fix/InvSnow-1.1.jar InvSnow.jar"
set "modData[10]=https://github.com/Yan-Jobs/mm-utils/releases/download/v1/MMUtils-1.0.jar MMUtils.jar"
set "modData[11]=https://github.com/Ultramicroscope/NameHistory/releases/download/weave-1.0/NameHistory-1.0.jar NameHistory.jar"
set "modData[12]=https://github.com/thaYt/oofmod/releases/download/v1.0/OofMod-1.0.jar OofMod.jar"
set "modData[13]=https://github.com/gabswastaken/OuchMod/releases/download/ouch/OuchMod-1.0.jar OuchMod.jar"
set "modData[14]=https://github.com/supercoolspy/PitUtilsLunar/releases/download/1.1.0/PitUtils-1.1.0.jar PitUtils.jar"
set "modData[15]=https://github.com/koxx12-dev/Weave-Raw-Input/releases/download/1.0.1/RawInput-1.0.1.jar RawInput.jar"
set "modData[16]=https://github.com/Zxnii/VanillaMenu/releases/download/v3.0.0/VanillaMenu-3.0.0.jar VanillaMenu.jar"
set "modData[17]=https://gitlab.com/candicey-weave/viaversion-lunar/uploads/9ba371b7abc07e0958ec559a9d9f0a30/ViaLunar-3.0.0.jar ViaLunar.jar"
set "modData[18]=https://github.com/Tryflle/WeaveChamsMod/releases/download/1.1-Release/WeaveChamsMod-1.1.jar WeaveChamsMod.jar"
set "modData[19]=https://github.com/770grappenmaker/weave-optifine-url/releases/download/v0.1/weave-optifine-url-0.1.jar weave-optifine-url.jar"
set "modData[20]=https://github.com/Tryflle/WeaveQuickReport/releases/download/1.1/WeaveQuickReport-1.1.jar WeaveQuickReport.jar"
set "modData[21]=https://gitlab.com/candicey-weave/wpk/-/package_files/96639835/download wpk.jar"
set "modData[22]=https://codeberg.org/Candicey-Weave/Zenith-Core/releases/download/v1.3.7/Zenith-Core-1.3.7.jar Zenith-Core.jar"

for %%i in (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22) do (
    for /f "tokens=1,2" %%a in ("!modData[%%i]!") do (
        if "%mods%"=="%%i" (
            call :DownloadFile "%%a" "%%b"
            move "%%b" "!modtargetDirectory!\%%b" > nul
            goto :mods
        )
    )
)

if /i "%mods%"=="23" goto :modscheats
if /i "%mods%"=="24" goto :am
goto :mods

:modscheats
set "modscheats="
call :Header
echo   Cheats:
echo   1) Blue Client [40;31m(Cheating Client)[40;37m
echo   2) Legit-ish [40;31m(Cheating Client)[40;37m
echo   3) NoHitDelay (Not needed for LCQT2)
echo   4) RavenWeave [40;31m(Cheating Client[40;37m, ZenithCore Required)
echo   5) RavenWeaveLite [40;31m(Cheating Client)[40;37m
echo   -------------------------------------------
echo   6) Go Back
echo.
set /p modscheats="Select an option: "

set "cheatData[1]=https://github.com/kacorvixon1337/blueclient/releases/download/release/blue-client.jar BlueClient"
set "cheatData[2]=https://github.com/legitish/Legit-ish-Weave/releases/download/latest/legitish-2.0.0.jar Legit-ish"
set "cheatData[3]=https://github.com/Nilsen84/WeaveNoHitDelay/releases/download/v2.0/WeaveNoHitDelay-2.0.jar NoHitDelay"
set "cheatData[4]=https://github.com/PianoPenguin471/RavenWeave/releases/download/1.1.3/RavenWeave-1.1.3.jar RavenWeave"
set "cheatData[5]=https://github.com/PianoPenguin471/RavenWeaveLite/releases/download/bugfix/RavenWeaveLite-1.0.jar RavenWeaveLite"

for %%i in (1 2 3 4 5) do (
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
if "%modscheats%"=="7" goto :mods
goto :modscheats

:utilities
set "tools="
call :Header
echo   Utilities:
echo   1) clumsy - Simulate network latency, delay, packet loss.
echo   2) Lilith - Hypixel proxy to improve user experience.
echo   -------------------------------------------
echo   3) Go Back

set /p tools="Select an option: "

set "utilityData[1]=https://github.com/jagt/clumsy/releases/download/0.3rc4/clumsy-0.3rc4-win32-a.zip clumsy.zip"

for %%i in (1) do (
    for /f "tokens=1,2" %%a in ("!utilityData[%%i]!") do (
        if "%tools%"=="1" (
            call :DownloadFile "%%a" "%%b"
            
            if "%%b"=="clumsy.zip" (
                mkdir clumsy
                tar -xf "%%b" --directory ./clumsy
                del "%%b"
            
                call :Header
                echo   Download Completed.
                timeout /t 2 > nul
            )
            
            goto :utilities
        )
    )
)

if "%tools%"=="2" (
    start https://docs.lilith.rip/lilith/install/windows
    goto :utilities
)
if "%tools%"=="3" goto :menu

:jres
set "jres="
call :Header
echo   JREs:
echo   1) GraalVM 17
echo   2) Zulu 17
echo   -------------------------------------------
echo   3) Go Back
echo.
set /p "jres=Select an option: "

if "%jres%"=="1" set "jreName=GraalVM" & set "jreFolder=graalvm-jdk17" & set "jreZip=graalvm-jdk17.zip" & set "jreDownloadUrl=https://download.oracle.com/graalvm/17/latest/graalvm-jdk-17_windows-x64_bin.zip"
if "%jres%"=="2" set "jreName=Zulu" & set "jreFolder=zulu-jdk17" & set "jreZip=zulu-jdk17.zip" & set "jreDownloadUrl=https://cdn.azul.com/zulu/bin/zulu17.44.53-ca-jre17.0.8.1-win_x64.zip"
if "%jres%"=="3" goto :menu

if not defined jreName (
    echo Invalid option selected.
    goto :jres
)

call :jreDownloader
goto :jres

:jreDownloader
call :Header
for /f "delims=" %%I in ('picker.exe folder 2^>^&1') do (
    set "pickerOutput=%%I"
)

for /f "tokens=*" %%A in ("!pickerOutput:Operation cancelled by the user.=!") do set "folderPath=%%A"
if "!folderPath!"=="" (
    echo No folder selected. Please select a folder.
    pause
    goto :selectFolder
)

set "folder=%folderPath%\%jreFolder%"
set "zip=%jreZip%"
set "downloadUrl=%jreDownloadUrl%"

if not exist "%zip%" (
    echo Downloading %jreName% from %downloadUrl%
    call :DownloadFile "%downloadUrl%" "%zip%"
    if errorlevel 1 (
        echo Failed to download %jreName%!
        pause
        goto :menu
    )
)

echo Extracting %jreName% to the specified folder...
mkdir "%folder%" 2>nul
tar -xzf "%zip%" -C "%folder%" --strip-components=1
del "%zip%" > nul 2>&1

echo Completed!
timeout /t 2 > nul
goto :eof

:lcd
call :Header
echo   [40;31mDowngrading will download the Lunar Client 2.16.1 Launcher files and delete version 3.
echo   Are you sure you want to continue?[40;37m
echo   -------------------------------------------
echo   Type 'Yes' to continue or type 'back' to go back.
echo.
set /p "dg="

if /i "%dg%"=="Yes" (
    call :Header
    echo [40;31mFinal warning, this will delete version 3.
    echo unethical is not liable for any damages done to your system.
    echo Please only use this if you know what you're doing.
    echo [40;37mYou can quit by pressing Alt+F4 or...
    echo Press any key to continue...
    pause >nul

    cls
    cURL -L https://unethicalcdn.com/lunarclient/Lunar%%20Client%%20v2.16.1.zip -o LCL.zip
    
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
    goto menu
)
if /i "%dg%"=="back" (
    goto :menu
)
goto :lcd

:multiver
call :Header
if exist "output.txt" (
    if exist "previous_output.txt" (
        del "previous_output.txt"
    )
    ren "output.txt" "previous_output.txt"
)

curl -X POST -H "Content-Type: application/json; charset=UTF-8" -H "User-Agent: Lunar Client Launcher v3.1.0" -d "{\"version\":\"1.8.9\",\"branch\":\"master\",\"os\":\"win32\",\"arch\":\"x64\",\"launcher_version\":\"3.1.0\",\"hwid\":\"hwid-private-do-not-share\"}" "https://api.lunarclientprod.com/launcher/launch" > "output.txt" && (
    echo Successfully requested from Lunar Client's API.
) || (
    echo Request unsuccessful.
    exit /b 1
)

if exist "previous_output.txt" (    
    fc "output.txt" "previous_output.txt" > nul

    if errorlevel 1 (
        set "LunarUpdated=true"
    ) else (
        set "LunarUpdated=false"
    )

    if "!LunarUpdated!"=="true" (
	echo Lunar has updated.
        for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (
            set "day=%%a"
            set "month=%%b"
            set "year=%%c"
        )
        for /f "tokens=1-3 delims=: " %%a in ('time /t') do (
            set "hour=%%a"
            set "minute=%%b"
            set "second=%%c"
        )
        set "timestamp=!year!!month!!day!_!hour!!minute!!second!"
        set "folderToBackup=%USERPROFILE%\.lunarclient\offline\multiver"

        echo Creating backup: multiver !timestamp! backup.zip
        powershell.exe -nologo -noprofile -command "Compress-Archive -Path '!folderToBackup!' -DestinationPath 'multiver !timestamp! backup.zip'" > nul
            
        if exist "multiver !timestamp! backup.zip" (
            echo Backup created successfully.
	    echo [40;31mDo not delete output.txt or previous_output.txt, this is for change detection from the API.[40;37m	
            pause
        ) else (
            echo Failed to create the backup.
            pause
        )
    ) else (
        echo No update detected.
	echo [40;31mDo not delete output.txt or previous_output.txt, this is for change detection from the API.[40;37m
	pause
    )
goto :menu
) else (
    if exist "output.txt" (
        for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (
            set "day=%%a"
            set "month=%%b"
            set "year=%%c"
        )
        for /f "tokens=1-3 delims=: " %%a in ('time /t') do (
            set "hour=%%a"
            set "minute=%%b"
            set "second=%%c"
        )
        set "timestamp=!year!!month!!day!_!hour!!minute!!second!"
        set "folderToBackup=%USERPROFILE%\.lunarclient\offline\multiver"

        echo Creating backup: multiver !timestamp! backup.zip
        powershell.exe -nologo -noprofile -command "Compress-Archive -Path '!folderToBackup!' -DestinationPath 'multiver !timestamp! backup.zip'" > nul
            
        if exist "multiver !timestamp! backup.zip" (
            echo Backup created successfully.	
	    echo [40;31mDo not delete output.txt, this is for change detection from the API.[40;37m
            pause
        )
    )
    goto :menu
)

:credits
call :Header
echo   Lunar Client QTs:
echo     Youded-Byte (QT) - [36mhttps://github.com/Youded-byte/lunar-client-qt[0m
echo     Nilsen84 (QT 2.0) - [36mhttps://github.com/Nilsen84[0m
echo.
echo   Lunar Client Launcher Inject:
echo     Nilsen84 - [36mhttps://github.com/Nilsen84/lunar-launcher-inject[0m
echo.
echo   Weave Loader:
echo     Weave Maintainers - [36mhttps://github.com/Weave-MC[0m
echo.
echo   Agents:
echo     Nilsen84 - [36mhttps://github.com/Nilsen84[0m
echo.
echo   Press any key to go back...
pause >nul
goto :menu

:license
call :Header
echo   lcbud Copyright (C) 2023 unethicalteam
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
call :Header
set "url=%~1"
set "output=%~2"
curl -L -o "!output!.tmp" "%url%"
if !errorlevel! neq 0 (
    call :Header
    echo Error downloading "!output!".
    echo.
    timeout /t 2 > nul
    del "!output!.tmp" 2>nul
)
move /y "!output!.tmp" "!output!"
goto :eof
