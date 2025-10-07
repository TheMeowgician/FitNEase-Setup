# 🚀 FitNEase Setup Guide for Groupmates

**Welcome!** This guide will help you run the complete FitNEase application on your laptop.

**Time needed:** 30-60 minutes

---

## 📋 Prerequisites (Install These First)

### 1. Docker Desktop ⭐ REQUIRED
**Download:** https://www.docker.com/products/docker-desktop/

**Windows:**
- Download "Docker Desktop for Windows"
- Run installer
- Restart computer when prompted
- **Important:** Allocate at least 4GB RAM to Docker
  - Open Docker Desktop → Settings → Resources → Memory → Set to 4GB+

**Mac:**
- Download "Docker Desktop for Mac"
- Install and open Docker Desktop
- Allocate 4GB+ RAM in settings

**Linux:**
- Follow instructions at: https://docs.docker.com/engine/install/

**Verify installation:**
```bash
docker --version
docker-compose --version
```

---

### 2. Node.js (version 18 or higher) ⭐ REQUIRED
**Download:** https://nodejs.org/

- Download the LTS (Long Term Support) version
- Run installer (choose default options)
- Restart terminal after installation

**Verify installation:**
```bash
node --version
npm --version
```

---

### 3. Git ⭐ REQUIRED
**Download:** https://git-scm.com/downloads

- Download for your OS
- Run installer (choose default options)

**Verify installation:**
```bash
git --version
```

---

### 4. Expo Go App (on your phone) 📱 REQUIRED
**For Android:**
- Google Play Store → Search "Expo Go" → Install

**For iPhone:**
- App Store → Search "Expo Go" → Install

---

## 🎯 Step-by-Step Setup

### STEP 1: Clone the Setup Repository (2 minutes)

Open terminal (Command Prompt on Windows, Terminal on Mac/Linux):

```bash
# Go to your desktop or projects folder
cd Desktop

# Clone the setup repository
git clone https://github.com/TheMeowgician/FitNEase-Setup.git

# Go into the folder
cd FitNEase-Setup
```

**What you should see:**
```
FitNEase-Setup/
├── docker-compose.yml
├── Dockerfile
├── README.md
├── clone-services.sh
├── clone-services.bat
└── .env.example
```

---

### STEP 2: Clone All Services (5-10 minutes)

**Windows:**
```bash
clone-services.bat
```

**Mac/Linux:**
```bash
chmod +x clone-services.sh
./clone-services.sh
```

**What this does:**
- Clones all 10 backend services
- Clones the mobile app
- Takes 5-10 minutes depending on internet speed

**Wait for it to complete!** You should see:
```
✅ All services cloned successfully!
```

**After completion, you should see:**
```
FitNEase-Setup/
├── docker-compose.yml
├── fitnease-auth/          ← NEW!
├── fitnease-social/        ← NEW!
├── fitnease-tracking/      ← NEW!
├── ... (8 more services)
└── fitnease-client/        ← NEW!
```

---

### STEP 3: Setup Environment Variables (5 minutes)

**Windows:**
```bash
copy .env.example .env
notepad .env
```

**Mac/Linux:**
```bash
cp .env.example .env
nano .env
```

**Edit the .env file and change these values:**

Find these lines and replace `CHANGE_THIS_PASSWORD` with your own passwords:

```env
# CHANGE THESE!
MYSQL_ROOT_PASSWORD=your_password_here
DB_PASSWORD=your_password_here
ML_SECRET_KEY=your_secret_key_here
```

**Example:**
```env
MYSQL_ROOT_PASSWORD=mypassword123
DB_PASSWORD=mypassword123
ML_SECRET_KEY=mysecretkey456
```

**Save and close the file.**

⚠️ **Important:** Use simple passwords for local testing (no special characters that might cause issues)

---

### STEP 4: Start Docker Desktop (1 minute)

1. Open **Docker Desktop** application
2. Wait until it says "Docker Desktop is running"
3. Keep it running in the background

---

### STEP 5: Start Backend Services (10 minutes)

```bash
# Make sure you're in FitNEase-Setup folder
cd FitNEase-Setup

# Start all services (this takes 5-10 minutes first time)
docker-compose up -d
```

**What this does:**
- Builds and starts 10 backend services
- Starts 10 databases
- Starts Redis cache
- Starts API Gateway

**First time will take 10-15 minutes** to download and build everything.

**Wait until you see:**
```
✅ All services started successfully
```

**Check status:**
```bash
docker-compose ps
```

All services should show "Up" or "healthy" status.

---

### STEP 6: Wait for Services to Initialize (2 minutes)

Services need time to start up completely.

**Wait 2-3 minutes**, then check logs:
```bash
docker-compose logs -f
```

Press `Ctrl+C` to stop viewing logs.

---

### STEP 7: Run Database Migrations (5 minutes)

Run these commands one by one:

```bash
docker-compose exec fitnease-auth php artisan migrate --force

docker-compose exec fitnease-social php artisan migrate --force

docker-compose exec fitnease-tracking php artisan migrate --force

docker-compose exec fitnease-content php artisan migrate --force

docker-compose exec fitnease-comms php artisan migrate --force

docker-compose exec fitnease-engagement php artisan migrate --force

docker-compose exec fitnease-media php artisan migrate --force

docker-compose exec fitnease-operations php artisan migrate --force

docker-compose exec fitnease-planning php artisan migrate --force
```

**Each command should show:**
```
Migration table created successfully.
Migrating: ...
Migrated: ...
```

---

### STEP 8: Start Mobile App (5 minutes)

**Open a NEW terminal window** (keep the other one open):

```bash
# Go to mobile app folder
cd FitNEase-Setup/fitnease-client

# Install dependencies (first time only)
npm install

# Start Expo
npx expo start
```

**Wait for QR code to appear.**

---

### STEP 9: Open App on Your Phone (2 minutes)

1. Open **Expo Go** app on your phone
2. **Make sure your phone and laptop are on the SAME WiFi network**
3. Scan the QR code from terminal

**Android:** Use Expo Go's built-in QR scanner

**iPhone:**
- Open Camera app
- Point at QR code
- Tap the notification that appears

**The app should open on your phone!** 🎉

---

### STEP 10: Test the App (5 minutes)

1. Click **"Register"**
2. Fill in your details
3. Create an account
4. Login
5. Explore the app!

**If everything works, you're done!** ✅

---

## 🆘 Troubleshooting

### Problem: "Docker daemon is not running"
**Solution:**
- Open Docker Desktop application
- Wait until it says "Running"
- Try command again

---

### Problem: "Port already in use"
**Solution:**
```bash
# Stop all services
docker-compose down

# Wait 10 seconds

# Start again
docker-compose up -d
```

---

### Problem: "Cannot connect to backend from mobile app"
**Solution:**

**Find your computer's IP address:**

**Windows:**
```bash
ipconfig
```
Look for "IPv4 Address" (e.g., 192.168.1.100)

**Mac:**
```bash
ifconfig | grep "inet "
```
Look for 192.168.x.x

**Update API configuration:**

Open: `fitnease-client/config/api.config.ts`

Change `localhost` to your IP address:
```typescript
// Change from:
baseURL: 'http://localhost:8090/auth'

// To:
baseURL: 'http://192.168.1.100:8090/auth'
```

Do this for all services in the config file.

Then restart Expo:
```bash
# In fitnease-client folder
npx expo start --clear
```

---

### Problem: Services won't start / Out of memory
**Solution:**
1. Close all other applications
2. Increase Docker memory:
   - Docker Desktop → Settings → Resources
   - Set Memory to 6GB or higher
   - Click "Apply & Restart"
3. Try again

---

### Problem: "migration" command fails
**Solution:**
```bash
# Check if service is running
docker-compose ps

# If service is not healthy, check logs
docker-compose logs fitnease-auth

# Wait 2-3 minutes and try again
```

---

### Problem: Expo QR code won't scan
**Solution:**
1. Make sure phone and laptop are on SAME WiFi
2. Try connection type:
   - Press `s` in terminal (switch to Expo Go)
   - Press `w` for web version (opens in browser)

---

### Problem: App shows blank screen
**Solution:**
```bash
# Clear cache and restart
npx expo start --clear
```

---

## 📞 Common Commands

### Start services:
```bash
cd FitNEase-Setup
docker-compose up -d
```

### Stop services:
```bash
docker-compose down
```

### View logs:
```bash
docker-compose logs -f
```

### Check status:
```bash
docker-compose ps
```

### Restart a specific service:
```bash
docker-compose restart fitnease-auth
```

### Start mobile app:
```bash
cd fitnease-client
npx expo start
```

---

## ✅ Success Checklist

You'll know everything is working when:

- [x] Docker Desktop shows all containers running
- [x] `docker-compose ps` shows all services "Up"
- [x] Mobile app opens in Expo Go
- [x] You can register a new account
- [x] You can login
- [x] You can see the dashboard
- [x] You can navigate between tabs

**If all checked, congratulations!** 🎉

---

## 💾 Stopping Everything

When you're done working:

```bash
# Stop all services
cd FitNEase-Setup
docker-compose down

# Stop Expo (press Ctrl+C in mobile app terminal)
```

**Next time you want to work:**
```bash
# Start services
docker-compose up -d

# Start mobile app
cd fitnease-client
npx expo start
```

---

## 📊 What's Running?

When everything is started, you have:

- ✅ 10 Backend services (auth, social, tracking, etc.)
- ✅ 10 MySQL databases
- ✅ 1 Redis cache
- ✅ 1 API Gateway (routes requests)
- ✅ 1 Mobile app (Expo)

**Total:** ~2-3 GB RAM usage

---

## 🎓 Tips

1. **Keep Docker Desktop running** while developing
2. **Phone and computer must be on same WiFi** for mobile app
3. **First startup is slow** (10-15 min), subsequent starts are fast (1-2 min)
4. **If something breaks**, try: `docker-compose down` then `docker-compose up -d`
5. **Don't close terminal** where Expo is running
6. **Check logs** if something doesn't work: `docker-compose logs -f`

---

## 📚 Folder Structure

```
FitNEase-Setup/
├── docker-compose.yml          # Main configuration
├── .env                        # Your passwords (DON'T commit!)
├── fitnease-auth/              # Authentication service
├── fitnease-social/            # Social features
├── fitnease-tracking/          # Workout tracking
├── fitnease-content/           # Exercise content
├── fitnease-comms/             # Communications
├── fitnease-engagement/        # User engagement
├── fitnease-media/             # Media storage
├── fitnease-ml/                # Machine learning
├── fitnease-operations/        # Operations
├── fitnease-planning/          # Planning
└── fitnease-client/            # Mobile app
```

---

## 🚀 You're Ready!

Follow the steps above and you'll have FitNEase running on your laptop!

**If you get stuck:**
1. Check the troubleshooting section
2. Read the error message carefully
3. Check logs: `docker-compose logs -f`
4. Ask in the group chat with screenshots

**Good luck!** 🎉

---

## 📝 Quick Reference Card

**Install:** Docker Desktop, Node.js, Git, Expo Go

**Setup:**
```bash
git clone https://github.com/TheMeowgician/FitNEase-Setup.git
cd FitNEase-Setup
./clone-services.sh    # or clone-services.bat
cp .env.example .env   # Edit passwords!
docker-compose up -d
# Run migrations (copy from STEP 7)
cd fitnease-client && npm install && npx expo start
```

**Daily Use:**
```bash
docker-compose up -d
cd fitnease-client && npx expo start
```

**Shutdown:**
```bash
docker-compose down
```

That's it! 🚀
