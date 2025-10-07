#!/bin/bash

echo "========================================"
echo "🔄 FitNEase - Update All Repositories"
echo "========================================"
echo ""

echo "📦 Updating FitNEase-Setup repository..."
git pull
echo ""

echo "🔄 Updating backend services..."
echo ""

services=("fitnease-auth" "fitnease-social" "fitnease-tracking" "fitnease-content" "fitnease-comms" "fitnease-engagement" "fitnease-media" "fitnease-ml" "fitnease-operations" "fitnease-planning")

count=1
total=${#services[@]}

for service in "${services[@]}"; do
    if [ -d "$service" ]; then
        echo "[$count/$total] Updating $service..."
        cd "$service"
        git pull
        cd ..
    else
        echo "⚠️  $service not found, skipping..."
    fi
    ((count++))
done

echo ""
echo "📱 Updating mobile app..."
if [ -d "fitnease-client" ]; then
    cd fitnease-client
    git pull
    cd ..
else
    echo "⚠️  fitnease-client not found, skipping..."
fi

echo ""
echo "========================================"
echo "✅ All repositories updated successfully!"
echo "========================================"
echo ""
echo "💡 Next steps:"
echo "1. If there were composer.json changes: Run composer install in services"
echo "2. If there were migration changes: Run migrations again"
echo "3. If there were package.json changes: Run npm install in fitnease-client"
echo ""
