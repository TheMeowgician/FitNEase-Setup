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

**Mac:**
- Download "Docker Desktop for Mac"
- Install and open Docker Desktop

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

⚠️ **IMPORTANT: Make sure you're in the FitNEase-Setup folder first!**

Check your current directory:
```bash
pwd    # Mac/Linux
cd     # Windows
```

You should see: `.../FitNEase-Setup`

If not, navigate to it:
```bash
cd FitNEase-Setup    # If you're one level up
```

**Now run the clone script:**

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

⚠️ **IMPORTANT: You should still be in the FitNEase-Setup folder**

Check your current directory:
```bash
pwd    # Mac/Linux - should show .../FitNEase-Setup
cd     # Windows - should show ...\FitNEase-Setup
```

**Now create and edit the .env file:**

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

⚠️ **IMPORTANT: Make sure you're in the FitNEase-Setup folder**

Check your current directory:
```bash
pwd    # Mac/Linux - should show .../FitNEase-Setup
cd     # Windows - should show ...\FitNEase-Setup
```

If you're not in FitNEase-Setup, navigate to it:
```bash
cd FitNEase-Setup
```

**Now start all services:**
```bash
docker-compose up -d
```

This takes 5-10 minutes the first time.

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

⚠️ **IMPORTANT: You should still be in the FitNEase-Setup folder**

Services need time to start up completely.

**Wait 2-3 minutes**, then check logs:
```bash
docker-compose logs -f
```

Press `Ctrl+C` to stop viewing logs.

---

### STEP 7: Run Database Migrations (5 minutes)

⚠️ **IMPORTANT: You should still be in the FitNEase-Setup folder**

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

**Open a NEW terminal window** (keep the other one open)

⚠️ **IMPORTANT: Check where you are first!**

```bash
pwd    # Mac/Linux
cd     # Windows
```

**Navigate to the mobile app folder:**

**If you're in FitNEase-Setup folder:**
```bash
cd fitnease-client
```

**If you're starting from Desktop or another location:**
```bash
# Windows example:
cd Desktop\FitNEase-Setup\fitnease-client

# Mac/Linux example:
cd Desktop/FitNEase-Setup/fitnease-client
```

**Verify you're in the right place** - you should see:
```bash
pwd    # Should show: .../FitNEase-Setup/fitnease-client
```

**Now install and start:**
```bash
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

⚠️ **Make sure you're in the FitNEase-Setup folder first!**

```bash
# Navigate to FitNEase-Setup folder
cd FitNEase-Setup    # Adjust path if needed

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

Navigate to the client folder and open the config file:
```bash
# From FitNEase-Setup folder:
cd fitnease-client

# Open the file with your editor (choose one):
notepad config/api.config.ts    # Windows
nano config/api.config.ts        # Mac/Linux
```

Change `localhost` to your IP address:
```typescript
// Change from:
baseURL: 'http://localhost:8090/auth'

// To:
baseURL: 'http://192.168.1.100:8090/auth'
```

Do this for all services in the config file.

Then restart Expo (make sure you're in fitnease-client folder):
```bash
pwd    # Should show: .../FitNEase-Setup/fitnease-client

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

⚠️ **Make sure you're in the FitNEase-Setup folder first!**

```bash
# Navigate to FitNEase-Setup folder
cd FitNEase-Setup    # Adjust path if needed

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

⚠️ **Make sure you're in the fitnease-client folder!**

```bash
# Navigate to fitnease-client folder
cd FitNEase-Setup/fitnease-client    # Adjust path if needed

# Verify you're in the right place
pwd    # Should show: .../FitNEase-Setup/fitnease-client

# Clear cache and restart
npx expo start --clear
```

---

## 📞 Common Commands

⚠️ **All commands require you to be in the correct directory!**

### Start services:
```bash
# Navigate to FitNEase-Setup folder first
cd FitNEase-Setup

# Then start services
docker-compose up -d
```

### Stop services:
```bash
# Must be in FitNEase-Setup folder
cd FitNEase-Setup
docker-compose down
```

### View logs:
```bash
# Must be in FitNEase-Setup folder
cd FitNEase-Setup
docker-compose logs -f
```

### Check status:
```bash
# Must be in FitNEase-Setup folder
cd FitNEase-Setup
docker-compose ps
```

### Restart a specific service:
```bash
# Must be in FitNEase-Setup folder
cd FitNEase-Setup
docker-compose restart fitnease-auth
```

### Start mobile app:
```bash
# Navigate to fitnease-client folder first
cd FitNEase-Setup/fitnease-client

# Verify you're in the right place
pwd    # Should show: .../FitNEase-Setup/fitnease-client

# Then start Expo
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
# 1. Stop Expo (press Ctrl+C in the terminal where Expo is running)

# 2. Stop all services - navigate to FitNEase-Setup folder
cd FitNEase-Setup
docker-compose down
```

**Next time you want to work:**
```bash
# 1. Start services (must be in FitNEase-Setup folder)
cd FitNEase-Setup
docker-compose up -d

# 2. Start mobile app (in a new terminal)
cd FitNEase-Setup/fitnease-client
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
# 1. Clone and navigate
git clone https://github.com/TheMeowgician/FitNEase-Setup.git
cd FitNEase-Setup

# 2. Clone all services
./clone-services.sh    # or clone-services.bat on Windows

# 3. Setup environment
cp .env.example .env   # Then edit passwords!

# 4. Start services
docker-compose up -d

# 5. Run migrations (copy from STEP 7)

# 6. Start mobile app (new terminal)
cd fitnease-client
npm install
npx expo start
```

**Daily Use:**
```bash
# Terminal 1 - Start backend (from FitNEase-Setup folder)
cd FitNEase-Setup
docker-compose up -d

# Terminal 2 - Start mobile app (from fitnease-client folder)
cd FitNEase-Setup/fitnease-client
npx expo start
```

**Shutdown:**
```bash
# Press Ctrl+C in Expo terminal, then:
cd FitNEase-Setup
docker-compose down
```

That's it! 🚀
