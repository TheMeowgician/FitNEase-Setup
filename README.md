# FitNEase Setup Guide for Groupmates

## 🎯 Quick Overview

This guide will help you run the **complete FitNEase app** (backend services + mobile app) on your laptop.

**What you'll run:**
- ✅ 10 Backend microservices (Docker containers)
- ✅ 10 MySQL databases
- ✅ Redis cache
- ✅ API Gateway
- ✅ Mobile app (React Native Expo)

**Time to setup:** 30-60 minutes
**System requirements:** Windows/Mac/Linux with 8GB+ RAM

---

## 📋 Prerequisites

### Required Software:
1. **Docker Desktop** - [Download here](https://www.docker.com/products/docker-desktop/)
2. **Git** - [Download here](https://git-scm.com/downloads)
3. **Node.js 18+** - [Download here](https://nodejs.org/)
4. **Expo Go App** - Install on your phone from App Store/Play Store

### System Requirements:
- 8GB RAM minimum (16GB recommended)
- 20GB free disk space
- Windows 10/11, macOS 10.15+, or Ubuntu 20.04+

---

## 🚀 Option 1: EASIEST WAY (Recommended)

### Step 1: Download Main Setup Repository

I'll create a **single main repository** with setup scripts that clones everything for you.

**For now, use this manual approach:**

```bash
# Create project folder
mkdir FitNEase
cd FitNEase

# Clone each service (replace YOUR_GITHUB_USERNAME with actual username)
git clone https://github.com/YOUR_GITHUB_USERNAME/fitnease-auth.git
git clone https://github.com/YOUR_GITHUB_USERNAME/fitnease-comms.git
git clone https://github.com/YOUR_GITHUB_USERNAME/fitnease-content.git
git clone https://github.com/YOUR_GITHUB_USERNAME/fitnease-engagement.git
git clone https://github.com/YOUR_GITHUB_USERNAME/fitnease-media.git
git clone https://github.com/YOUR_GITHUB_USERNAME/fitnease-ml.git
git clone https://github.com/YOUR_GITHUB_USERNAME/fitnease-operations.git
git clone https://github.com/YOUR_GITHUB_USERNAME/fitnease-planning.git
git clone https://github.com/YOUR_GITHUB_USERNAME/fitnease-social.git
git clone https://github.com/YOUR_GITHUB_USERNAME/fitnease-tracking.git

# Clone mobile app (you'll create this)
git clone https://github.com/YOUR_GITHUB_USERNAME/fitnease-client.git
```

### Step 2: Download Docker Files

I need to create a main repo with:
- `docker-compose.yml`
- `Dockerfile`
- `.env.example`
- Setup scripts

**For now, I'll send you these files separately.**

### Step 3: Setup Environment

```bash
# Copy environment template
cp .env.example .env

# Edit .env file and set passwords
nano .env  # or use any text editor
```

### Step 4: Start Backend Services

```bash
# Start all services (takes 5-10 minutes first time)
docker-compose up -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f
```

### Step 5: Run Database Migrations

```bash
# Run migrations for all services
docker-compose exec fitnease-auth php artisan migrate
docker-compose exec fitnease-social php artisan migrate
docker-compose exec fitnease-tracking php artisan migrate
# ... (do for all services)
```

### Step 6: Start Mobile App

```bash
# Go to client folder
cd fitnease-client

# Install dependencies
npm install

# Start Expo
npx expo start
```

### Step 7: Test on Phone

1. Open **Expo Go** app on your phone
2. Scan the QR code from terminal
3. App should open!

---

## 🛠️ Option 2: I'LL CREATE A SETUP REPO FOR YOU

This is the **BEST** way. Let me create:

### Main Repository: `fitnease-setup`

Structure:
```
fitnease-setup/
├── docker-compose.yml          # Orchestrates all services
├── Dockerfile                  # Main Docker build file
├── .env.example               # Environment template
├── nginx-gateway.conf         # API Gateway config
├── setup.sh                   # Auto-setup script (Mac/Linux)
├── setup.bat                  # Auto-setup script (Windows)
├── README.md                  # Instructions
└── scripts/
    ├── clone-all.sh          # Clones all service repos
    ├── start-services.sh     # Starts Docker services
    ├── run-migrations.sh     # Runs all migrations
    └── stop-services.sh      # Stops everything
```

### `setup.sh` Script (Auto-setup everything)

```bash
#!/bin/bash
# FitNEase Auto Setup Script

echo "🚀 FitNEase Auto Setup Starting..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker Desktop first."
    exit 1
fi

# Create directories
mkdir -p services

# Clone all services
echo "📦 Cloning all services..."
cd services

GITHUB_USER="YOUR_GITHUB_USERNAME"  # Replace with your GitHub username

git clone https://github.com/$GITHUB_USER/fitnease-auth.git
git clone https://github.com/$GITHUB_USER/fitnease-comms.git
git clone https://github.com/$GITHUB_USER/fitnease-content.git
git clone https://github.com/$GITHUB_USER/fitnease-engagement.git
git clone https://github.com/$GITHUB_USER/fitnease-media.git
git clone https://github.com/$GITHUB_USER/fitnease-ml.git
git clone https://github.com/$GITHUB_USER/fitnease-operations.git
git clone https://github.com/$GITHUB_USER/fitnease-planning.git
git clone https://github.com/$GITHUB_USER/fitnease-social.git
git clone https://github.com/$GITHUB_USER/fitnease-tracking.git

cd ..

# Setup environment
if [ ! -f .env ]; then
    echo "⚙️ Creating .env file..."
    cp .env.example .env
    echo "📝 Please edit .env file with your settings"
fi

# Start services
echo "🐳 Starting Docker services..."
docker-compose up -d

echo "⏳ Waiting for services to start (60 seconds)..."
sleep 60

# Run migrations
echo "📊 Running database migrations..."
docker-compose exec -T fitnease-auth php artisan migrate --force
docker-compose exec -T fitnease-social php artisan migrate --force
docker-compose exec -T fitnease-tracking php artisan migrate --force
docker-compose exec -T fitnease-content php artisan migrate --force
docker-compose exec -T fitnease-comms php artisan migrate --force
docker-compose exec -T fitnease-engagement php artisan migrate --force
docker-compose exec -T fitnease-media php artisan migrate --force
docker-compose exec -T fitnease-operations php artisan migrate --force
docker-compose exec -T fitnease-planning php artisan migrate --force

echo "✅ Backend setup complete!"
echo ""
echo "📱 To start mobile app:"
echo "   cd fitnease-client"
echo "   npm install"
echo "   npx expo start"
echo ""
echo "🌐 API Gateway: http://localhost:8090"
echo "🔍 Health check: http://localhost:8090/health"
```

---

## 📱 Mobile App Setup

### You NEED to push fitnease-client to GitHub

```bash
# Go to fitnease-client folder
cd fitnease-client

# Initialize git (if not already)
git init

# Create .gitignore
echo "node_modules/
.expo/
.expo-shared/
dist/
npm-debug.*
*.jks
*.p8
*.p12
*.key
*.mobileprovision
*.orig.*
web-build/
.env" > .gitignore

# Add all files
git add .

# Commit
git commit -m "Initial commit: FitNEase mobile app"

# Create repository on GitHub (go to github.com, create new repo: fitnease-client)

# Link and push
git remote add origin https://github.com/YOUR_USERNAME/fitnease-client.git
git branch -M main
git push -u origin main
```

---

## 🔧 Troubleshooting

### Problem: Docker services won't start
**Solution:**
```bash
# Check Docker Desktop is running
docker info

# Check memory allocated (needs 4GB+)
# Docker Desktop → Settings → Resources → Memory
```

### Problem: Port already in use
**Solution:**
```bash
# Stop existing services
docker-compose down

# Or change ports in docker-compose.yml
```

### Problem: Expo won't start
**Solution:**
```bash
# Clear cache
npx expo start --clear

# Reinstall dependencies
rm -rf node_modules package-lock.json
npm install
```

### Problem: Can't connect to backend from phone
**Solution:**
```bash
# Find your computer's IP address

# Windows
ipconfig
# Look for "IPv4 Address" (e.g., 192.168.1.100)

# Mac/Linux
ifconfig | grep "inet "
# Look for 192.168.x.x

# Update API URLs in fitnease-client/services/api/client.ts
# Change "localhost" to your IP address
# Example: http://192.168.1.100:8090
```

---

## 📞 Common Commands

### Start everything:
```bash
docker-compose up -d
```

### Stop everything:
```bash
docker-compose down
```

### View logs:
```bash
docker-compose logs -f
```

### Restart a service:
```bash
docker-compose restart fitnease-auth
```

### Check service status:
```bash
docker-compose ps
```

### Run migrations:
```bash
docker-compose exec fitnease-auth php artisan migrate
```

---

## 🎥 Video Tutorial (To be created)

I recommend creating a **5-minute video** showing:
1. Cloning repositories
2. Running setup script
3. Starting mobile app
4. Testing on phone

---

## ✅ Quick Test Checklist

After setup, verify:
- [ ] Docker Desktop is running
- [ ] All services show "healthy" in `docker-compose ps`
- [ ] Can access http://localhost:8090/health
- [ ] Mobile app opens in Expo Go
- [ ] Can register a new user
- [ ] Can login
- [ ] Can see dashboard

---

## 💡 Tips for Groupmates

1. **Allocate 4GB+ RAM to Docker** (in Docker Desktop settings)
2. **Use WiFi, not mobile data** when testing
3. **Keep Docker Desktop running** while developing
4. **Computer and phone must be on same network**
5. **Close other apps** to save memory
6. **First build takes 10-20 minutes** (subsequent starts are fast)

---

## 🆘 Need Help?

**If something doesn't work:**
1. Check Docker Desktop is running
2. Run `docker-compose logs -f` to see errors
3. Search error message on Google
4. Ask in group chat with error screenshots

**Common issues:**
- Out of memory → Close other apps, restart Docker
- Port in use → Change port in docker-compose.yml
- Can't connect → Check firewall, use correct IP address

---

## 📝 Project Structure

```
FitNEase/
├── docker-compose.yml       # Main orchestration file
├── Dockerfile              # Docker build configuration
├── .env                    # Environment variables (create from .env.example)
├── nginx-gateway.conf      # API Gateway configuration
│
├── fitnease-auth/          # Authentication service
├── fitnease-social/        # Social features (groups, friends)
├── fitnease-tracking/      # Workout tracking
├── fitnease-content/       # Exercise content
├── fitnease-ml/           # Machine learning recommendations
├── fitnease-comms/        # Communications
├── fitnease-engagement/   # User engagement
├── fitnease-media/        # Media storage
├── fitnease-operations/   # Operations management
├── fitnease-planning/     # Workout planning
│
└── fitnease-client/       # Mobile app (React Native + Expo)
```

---

## 🚀 Ready to Deploy?

Once everything works locally:
1. Follow `AWS_DEPLOYMENT_GUIDE.txt` to deploy to AWS
2. Update API URLs in mobile app to use AWS IP
3. Build APK/IPA for distribution

Good luck! 🎉
