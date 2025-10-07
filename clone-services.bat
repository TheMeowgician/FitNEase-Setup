@echo off
REM FitNEase - Clone All Services Script
REM For Windows

echo ==================================================================================
echo FitNEase - Cloning All Services
echo ==================================================================================

REM Change this to your GitHub username
set GITHUB_USER=TheMeowgician

echo GitHub User: %GITHUB_USER%
echo.

REM Check if git is installed
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Git is not installed. Please install Git first.
    pause
    exit /b 1
)

echo Cloning backend services...
git clone https://github.com/%GITHUB_USER%/FitNEase-Auth-Service.git fitnease-auth
git clone https://github.com/%GITHUB_USER%/FitNEase-Communication-Service.git fitnease-comms
git clone https://github.com/%GITHUB_USER%/FitNEase-Content-Service.git fitnease-content
git clone https://github.com/%GITHUB_USER%/FitNEase-Engagement-Service.git fitnease-engagement
git clone https://github.com/%GITHUB_USER%/FitNEase-Media-Service.git fitnease-media
git clone https://github.com/%GITHUB_USER%/FitNEase-ML-Service.git fitnease-ml
git clone https://github.com/%GITHUB_USER%/FitNEase-Operations-Service.git fitnease-operations
git clone https://github.com/%GITHUB_USER%/FitNEase-Planning-Service.git fitnease-planning
git clone https://github.com/%GITHUB_USER%/FitNEase-Social-Service.git fitnease-social
git clone https://github.com/%GITHUB_USER%/FitNEase-Tracking-Service.git fitnease-tracking

echo.
echo Cloning mobile app...
git clone https://github.com/%GITHUB_USER%/FitNEase-Client.git fitnease-client

echo.
echo All services cloned successfully!
echo.
echo Next steps:
echo    1. copy .env.example .env
echo    2. Edit .env file with your passwords
echo    3. start-backend.bat
echo.
pause
