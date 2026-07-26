@echo off
:: Title of the window
title Git Auto Update - SW Sayoni Hotel ^& Restaurant

echo ===================================================
echo   SW Sayoni Hotel ^& Restaurant - Git Update Tool
echo ===================================================
echo.

:: Check if git is installed
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Git is not installed or not in PATH!
    echo Please install Git and try again.
    goto end
)

:: Get current branch
for /f "tokens=*" %%i in ('git branch --show-current') do set CURRENT_BRANCH=%%i
if "%CURRENT_BRANCH%"=="" (
    set CURRENT_BRANCH=main
)

echo Current Git Branch: %CURRENT_BRANCH%
echo.

:: Prompt for commit message
set /p commit_msg="Enter commit message (Press Enter for default: 'Update Website'): "

:: Set default message if empty
if "%commit_msg%"=="" (
    set commit_msg=Update Website
)

echo.
echo [1/3] Adding files to git staging area...
git add .
if %errorlevel% neq 0 (
    echo [ERROR] Failed to add files!
    goto end
)

echo.
echo [2/3] Committing changes with message: "%commit_msg%"...
git commit -m "%commit_msg%"
if %errorlevel% neq 0 (
    echo [WARNING] Nothing to commit or commit failed!
    :: Don't exit, maybe we can still try to push if there are unpushed commits
)

echo.
echo [3/3] Pushing changes to remote origin/%CURRENT_BRANCH%...
git push origin %CURRENT_BRANCH%
if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Failed to push changes to GitHub!
    echo Please check your internet connection or git credentials.
    goto end
)

echo.
echo ===================================================
echo [SUCCESS] Git update completed successfully!
echo ===================================================

:end
echo.
pause
