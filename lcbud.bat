@echo off
set ver=v1.3
setlocal EnableDelayedExpansion

:setDefaults
set "downloadlcqt=No"
set "downloadlcqt2=No"
set "downloadlli=No"
set "downloadwl=No"

title lcbud %ver%

:menu
cls
echo.
echo lcbud - Lunar Client Batch Utility Downloader: %ver%
echo.
set "input="
echo This is the main menu. 
echo Type 1, 2, 3, or 4 to toggle, and hit enter.
echo Or, type 5, 6, 7, or 8 to be redirected.
echo.
echo 1. Download Lunar Client QT: %downloadlcqt%
echo 2. Download Lunar Client QT 2.0 (Nils): %downloadlcqt2%
echo 3. Download Lunar Launcher Inject: %downloadlli%
echo 4. Download Weave Loader: %downloadwl%
echo -------------------------------------------
echo 5. Download Agents / Mods
echo 6. Downgrade Lunar Client Launcher to 2.16.1
echo 7. Credits
echo 8. License
echo 9. Exit
echo.
set /p input="Enter Corresponding Number and Hit Enter: "

if "%input%"=="1" (
    if "%downloadlcqt%"=="No" (
        set "downloadlcqt=Yes"
    ) else (
        set "downloadlcqt=No"
    )
) else if "%input%"=="2" (
    if "%downloadlcqt2%"=="No" (
        set "downloadlcqt2=Yes"
    ) else (
        set "downloadlcq2t=No"
    )
) else if "%input%"=="3" (
    if "%downloadlli%"=="No" (
        set "downloadlli=Yes"
    ) else (
        set "downloadlli=No"
    )
) else if "%input%"=="4" (
    if "%downloadwl%"=="No" (
        set "downloadwl=Yes"
    ) else (
        set "downloadwl=No"
    )
) else if "%input%"=="5" (
    goto :am
) else if "%input%"=="6" (
    goto :lcd
) else if "%input%"=="7" (
    goto :credits
) else if "%input%"=="8" (
    goto :license
) else if "%input%"=="9" (
    exit /b
) else (
    goto :start
)

goto :menu

:start
cls
if "%downloadlcqt%"=="No" if "%downloadlcqt2%"=="No" "%downloadlli%"=="No" if "%downloadwl%"=="No" goto :errorNoInstallsSelected

if /i "%downloadlcqt%"=="Yes" (
    call :DownloadFile "https://github.com/Youded-byte/lunar-client-qt/releases/latest/download/windows.zip" "lcqt.zip"
    mkdir lcqt
    tar -xf lcqt.zip --directory ./lcqt
    del lcqt.zip
)

if /i "%downloadlcqt2%"=="Yes" (
    call :DownloadFile "https://github.com/Nilsen84/lcqt2/releases/latest/download/windows-portable.zip" "lcqt2-nils.zip"
    mkdir lcqt2-nils
    tar -xf lcqt2-nils.zip --directory ./lcqt2-nils
    del lcqt2-nils.zip
)

if /i "%downloadlli%"=="Yes" (
    call :DownloadFile "https://github.com/Nilsen84/lunar-launcher-inject/releases/download/v1.3.0/lunar-launcher-inject-windows-1.3.0.exe" "lunar-launcher-inject.exe"
)

if /i "%downloadwl%"=="Yes" (
    call :DownloadFile "https://github.com/Weave-MC/Weave-Loader/releases/download/v0.2.3/Weave-Loader-Agent-0.2.3.jar" "Weave-Loader-Agent-0.2.3.jar"
)

goto :downloadCompleted

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
echo 3. Back
echo 4. Exit
echo.
set /p am="Enter Corresponding Number and Hit Enter: "

if "%am%"=="1" (
    goto :agents
) else if "%am%"=="2" (
    goto :mods
) else if "%am%"=="3" (
    goto :menu
) else if "%am%"=="4" (
    exit /b
)

:agents
set "agents="
cls
echo.
echo lcbud - Lunar Client Batch Utility Downloader: %ver%
echo.
echo Agents:
echo 1. CrackedAccount
echo 2. CustomAutoGG
echo 3. CustomLevelHead
echo 4. HitDelayFix
echo 5. LevelHeadNicks
echo 6. LunarEnable
echo 7. LunarPacksFix
echo 8. NoPinnedServers
echo 9. RemovePlus
echo 10. StaffEnable
echo 11. TeamsAutoGG
echo -------------------------------------------
echo 12. Back
echo 13. Exit
echo.
set /p agents="Which would you like to download?: "

if /i "%agents%"=="1" (
    call :DownloadFile "https://github.com/Nilsen84/lunar-client-agents/releases/latest/download/CrackedAccount.jar" "CrackedAccount.jar"
    goto :agents
)

if /i "%agents%"=="2" (
    call :DownloadFile "https://github.com/Nilsen84/lunar-client-agents/releases/latest/download/CustomAutoGG.jar" "CustomAutoGG.jar"
    goto :agents
)

if /i "%agents%"=="3" (
    call :DownloadFile "https://github.com/Nilsen84/lunar-client-agents/releases/latest/download/CustomLevelHead.jar" "CustomLevelHead.jar"
    goto :agents
)

if /i "%agents%"=="4" (
    call :DownloadFile "https://github.com/Nilsen84/lunar-client-agents/releases/latest/download/HitDelayFix.jar" "HitDelayFixAgent.jar"
    goto :agents
)

if /i "%agents%"=="5" (
    call :DownloadFile "https://github.com/Nilsen84/lunar-client-agents/releases/latest/download/LevelHeadNicks.jar" "LevelHeadNicks.jar"
    goto :agents
)

if /i "%agents%"=="6" (
    call :DownloadFile "https://github.com/Nilsen84/lunar-client-agents/releases/latest/download/LunarEnable.jar" "LunarEnable.jar"
    goto :agents
)

if /i "%agents%"=="7" (
    call :DownloadFile "https://github.com/Nilsen84/lunar-client-agents/releases/latest/download/LunarPacksFix.jar" "LunarPacksFix.jar"
    goto :agents
)

if /i "%agents%"=="8" (
    call :DownloadFile "https://github.com/Nilsen84/lunar-client-agents/releases/latest/download/NoPinnedServers.jar" "NoPinnedServers.jar"
    goto :agents
)

if /i "%agents%"=="9" (
    call :DownloadFile "https://github.com/Nilsen84/lunar-client-agents/releases/latest/download/RemovePlus.jar" "RemovePlus.jar"
    goto :agents
)

if /i "%agents%"=="10" (
    call :DownloadFile "https://github.com/Nilsen84/lunar-client-agents/releases/latest/download/StaffEnable.jar" "StaffEnable.jar"
    goto :agents
)

if /i "%agents%"=="11" (
    call :DownloadFile "https://github.com/Nilsen84/lunar-client-agents/releases/latest/download/TeamsAutoGG.jar" "TeamsAutoGG.jar"
    goto :agents
)

if /i "%agents%"=="12" goto :am
if /i "%agents%"=="13" goto :eof

echo "%agents%" is not valid
echo.
goto :agents

:mods
set "mods="
cls
echo.
echo lcbud - Lunar Client Batch Utility Downloader: %ver%
echo.
echo Mods:
echo 1. Raw Input
echo 2. NoHitDelay
echo 3. RavenWeave [40;31m(Cheating Client)
echo [40;37m4. Fractal [40;31m(Cheating Client)
echo [40;37m5. VapeFix
echo 6. VanillaMenu -  Bring back the vanilla Minecraft main menu
echo 7. PitUtils - Hypixel Pit Utilities
echo 8. FPS - Custom FPS Limit
echo 9. MMUtils - Hypixel Murder Mystery Utilities
echo 10. ToggleChat (ZenithCore Required)
echo 11. Weave Mod Menu - A Mod Menu for Weave
echo 12. ViaLunar - Joining 1.9+ servers from LunarClient 1.8 (ZenithCore Required)
echo 13. ZenithCore - Dependency for mods
echo -------------------------------------------
echo 14. Back
echo 15. Exit
echo.
set /p mods="Which would you like to download?: "

if /i "%mods%"=="1" (
    call :DownloadFile "https://github.com/koxx12-dev/Weave-Raw-Input/releases/download/1.0.1/RawInput-1.0.1.jar" "RawInput.jar"
    goto :mods
)

if /i "%mods%"=="2" (
    call :DownloadFile "https://github.com/Nilsen84/WeaveNoHitDelay/releases/download/v2.0/WeaveNoHitDelay-2.0.jar" "WeaveNoHitDelay.jar"
    goto :mods
)

if /i "%mods%"=="3" (
    call :DownloadFile "https://github.com/PianoPenguin471/RavenWeave/releases/download/1.1.3/RavenWeave-1.1.3.jar" "RavenWeave.jar"
    goto :mods
)

if /i "%mods%"=="4" (
    call :DownloadFile "https://github.com/AriaJackie/Fractal/releases/download/release-1.2/fractal-weave-1.2.jar" "Fractal.jar"
    goto :mods
)

if /i "%mods%"=="5" (
    call :DownloadFile "https://github.com/Zircta/VapeFix/releases/download/2.0/VapeFix-2.0.jar" "VapeFix.jar"
    goto :mods
)

if /i "%mods%"=="6" (
    call :DownloadFile "https://github.com/Zxnii/VanillaMenu/releases/download/v3.0.0/VanillaMenu-3.0.0.jar" "VanillaMenu.jar"
    goto :mods
)

:: if /i "%mods%"=="7" (
::    call :DownloadFile "https://github.com/supercoolspy/PitUtilsLunar/releases/download/1.1.0/PitUtils-1.1.0.jar" "PitUtils.jar"
::    goto :mods
:: )

if /i "%mods%"=="8" (
    call :DownloadFile "https://github.com/Zircta/FPS/releases/download/1.0/FPS-1.0.jar" "FPS.jar"
    goto :mods
)

if /i "%mods%"=="9" (
    call :DownloadFile "https://github.com/Yan-Jobs/mm-utils/releases/download/v1/MMUtils-1.0.jar" "MMUtils.jar"
    goto :mods
)

if /i "%mods%"=="10" (
    call :DownloadFile "https://github.com/Zircta/ToggleChat/releases/download/1.2/ToggleChat-1.2.jar" "ToggleChat.jar"
    goto :mods
)

:: if /i "%mods%"=="11" (
::    call :DownloadFile "https://github.com/betterclient/Weave-mod-menu/releases/download/first/WeavedModMenu-1.0.jar" "WeavedModMenu.jar"
::    goto :mods
:: )

if /i "%mods%"=="12" (
    call :DownloadFile "https://gitlab.com/candicey-weave/viaversion-lunar/uploads/9ba371b7abc07e0958ec559a9d9f0a30/ViaLunar-3.0.0.jar" "ViaLunar.jar"
    goto :mods
)

if /i "%mods%"=="13" (
    call :DownloadFile "https://gitlab.com/candicey-weave/zenith-core/uploads/78fba051d9347fe95c102ccab338a750/Zenith-Core-1.2.0.jar" "Zenith-Core.jar"
    goto :mods
)

if /i "%mods%"=="14" goto :am
if /i "%mods%"=="15" goto :eof

rem Disabled Mod Downloads
if /i "%mods%"=="7" goto :errorDisabledModDownload
if /i "%mods%"=="11" goto :errorDisabledModDownload

echo "%mods%" is not valid
echo.
goto :mods

:lcd
cls
echo.
echo lcbud - Lunar Client Batch Utility Downloader: %ver%
echo.
echo Downgrading will download the Lunar Client 2.16.1 Launcher files and delete 3.0.x.
echo Are you sure you want to continue?
echo -------------------------------------------
echo Type `continue` or type `back` to go back.
echo.
set /p dg=""

if /i "%dg%"=="continue" (
cls
echo.
echo lcbud - Lunar Client Batch Utility Downloader: %ver%
echo.
echo Final warning, this will delete 3.0.x.
echo unethical is not liable for any damages done to your system.
echo Please only use this if you know what you're doing.
echo You can quit by pressing Alt+F4 or...
echo Press any key to continue...
pause >nul
goto :lclcontinue	
)

if /i "%dg%"=="back" (
goto :menu
)

echo "%dg%" is not valid
echo.
goto :lcd

:lclcontinue
call :DownloadFile "https://cdn.discordapp.com/attachments/1140173680018735144/1140453928056672358/Lunar_Client_v2.16.1.zip" "LCL.zip"
mkdir lcl
tar -xf lcl.zip --directory ./lcl
del LCL.zip
rmdir /S /Q %localappdata%\programs\launcher
xcopy /e lcl\launcher %localappdata%\programs\launcher\
goto :menu	

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
set "details="
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
set /p details="lcbud.bat: "

if /i "%details%"=="license" (
cls
echo.
echo lcbud - Lunar Client Batch Utility Downloader: %ver%
echo.
echo This will open a browser window and return you to the menu.
echo Press any key to continue...
pause >nul
start https://choosealicense.com/licenses/lgpl-3.0/
goto :menu
)

if /i "%details%"=="back" (
goto :menu
)

rem DownloadFile subroutine
:DownloadFile
cls
echo.
echo lcbud - Lunar Client Batch Utility Downloader: %ver%
echo.
set "url=%~1"
set "output=%~2"
curl -L "%url%" > "%output%" 
goto :eof

rem Errors
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

:errorNoInstallsSelected
cls
echo.
echo lcbud - Lunar Client Batch Utility Downloader: %ver%
echo.
echo [40;31mError: [40;37mYou didn't select anything to be downloaded! 
echo Please set at least one of the options to: Yes
echo.
pause
goto :menu
