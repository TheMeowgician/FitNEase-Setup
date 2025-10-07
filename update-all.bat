@echo off
echo ========================================
echo 🔄 FitNEase - Update All Repositories
echo ========================================
echo.

echo 📦 Updating FitNEase-Setup repository...
git pull
echo.

echo 🔄 Updating backend services...
echo.

if exist fitnease-auth (
    echo [1/10] Updating fitnease-auth...
    cd fitnease-auth
    git pull
    cd ..
) else (
    echo ⚠️  fitnease-auth not found, skipping...
)

if exist fitnease-social (
    echo [2/10] Updating fitnease-social...
    cd fitnease-social
    git pull
    cd ..
) else (
    echo ⚠️  fitnease-social not found, skipping...
)

if exist fitnease-tracking (
    echo [3/10] Updating fitnease-tracking...
    cd fitnease-tracking
    git pull
    cd ..
) else (
    echo ⚠️  fitnease-tracking not found, skipping...
)

if exist fitnease-content (
    echo [4/10] Updating fitnease-content...
    cd fitnease-content
    git pull
    cd ..
) else (
    echo ⚠️  fitnease-content not found, skipping...
)

if exist fitnease-comms (
    echo [5/10] Updating fitnease-comms...
    cd fitnease-comms
    git pull
    cd ..
) else (
    echo ⚠️  fitnease-comms not found, skipping...
)

if exist fitnease-engagement (
    echo [6/10] Updating fitnease-engagement...
    cd fitnease-engagement
    git pull
    cd ..
) else (
    echo ⚠️  fitnease-engagement not found, skipping...
)

if exist fitnease-media (
    echo [7/10] Updating fitnease-media...
    cd fitnease-media
    git pull
    cd ..
) else (
    echo ⚠️  fitnease-media not found, skipping...
)

if exist fitnease-ml (
    echo [8/10] Updating fitnease-ml...
    cd fitnease-ml
    git pull
    cd ..
) else (
    echo ⚠️  fitnease-ml not found, skipping...
)

if exist fitnease-operations (
    echo [9/10] Updating fitnease-operations...
    cd fitnease-operations
    git pull
    cd ..
) else (
    echo ⚠️  fitnease-operations not found, skipping...
)

if exist fitnease-planning (
    echo [10/10] Updating fitnease-planning...
    cd fitnease-planning
    git pull
    cd ..
) else (
    echo ⚠️  fitnease-planning not found, skipping...
)

echo.
echo 📱 Updating mobile app...
if exist fitnease-client (
    cd fitnease-client
    git pull
    cd ..
) else (
    echo ⚠️  fitnease-client not found, skipping...
)

echo.
echo ========================================
echo ✅ All repositories updated successfully!
echo ========================================
echo.
echo 💡 Next steps:
echo 1. If there were composer.json changes: Run composer install in services
echo 2. If there were migration changes: Run migrations again
echo 3. If there were package.json changes: Run npm install in fitnease-client
echo.
pause
