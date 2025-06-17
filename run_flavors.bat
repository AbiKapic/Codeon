@echo off
echo Codeon Flutter App - Flavor Runner
echo =================================
echo.
echo Available flavors:
echo 1. Local
echo 2. Dev
echo 3. Prod
echo.
set /p choice="Select flavor (1-3): "

if "%choice%"=="1" (
    echo Running Local flavor...
    flutter run --flavor local -t lib/src/entry_points/main_local.dart
) else if "%choice%"=="2" (
    echo Running Dev flavor...
    flutter run --flavor dev -t lib/src/entry_points/main_dev.dart
) else if "%choice%"=="3" (
    echo Running Prod flavor...
    flutter run --flavor prod -t lib/src/entry_points/main_prod.dart
) else (
    echo Invalid choice. Please select 1, 2, or 3.
    pause
) 