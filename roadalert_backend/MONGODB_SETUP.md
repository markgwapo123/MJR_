# MongoDB Atlas Connection Guide

## Step 1: Go to MongoDB Atlas
1. Visit https://cloud.mongodb.com/
2. Sign in to your account (or create one if you don't have it)

## Step 2: Create/Select Your Cluster
1. If you don't have a cluster, click "Build a Database" → "Shared" (free tier)
2. Choose your cloud provider and region
3. Create cluster (takes 1-3 minutes)

## Step 3: Create Database User
1. In your cluster, go to "Database Access" (left sidebar)
2. Click "Add New Database User"
3. Choose "Password" authentication
4. Enter username and password (remember these!)
5. Give "Read and write to any database" permission
6. Click "Add User"

## Step 4: Configure Network Access
1. Go to "Network Access" (left sidebar)
2. Click "Add IP Address"
3. Click "Allow Access from Anywhere" (for development)
4. Or add your specific IP address
5. Click "Confirm"

## Step 5: Get Connection String
1. Go back to "Database" → "Connect"
2. Choose "Connect your application"
3. Select "Node.js" and version "4.1 or later"
4. Copy the connection string that looks like:
   mongodb+srv://<username>:<password>@cluster0.xxxxx.mongodb.net/?retryWrites=true&w=majority

## Step 6: Update Your .env File
Replace the connection string in your .env file:
MONGODB_URI=mongodb+srv://yourusername:yourpassword@cluster0.xxxxx.mongodb.net/roadalert?retryWrites=true&w=majority

Note: Replace <password> with your actual password, and add "/roadalert" before the "?" to specify your database name.
