#!/usr/bin/env bash

# Clone the repository
echo "Cloning the repository..."
git clone https://github.com/AminZibayi/HoneyMap.git

# Navigate to the HoneyMap directory 
cd ./HoneyMap

# Install system dependencies
echo "Installing system dependencies..."
sudo apt install python3-pip redis-server;

# Install python requirements
echo "Installing python dependencies..."
sudo pip3 install -U -r requirements.txt

# Configure the DB
echo "Downloading geoip database..."
cd ./DB
chmod +x ./db-dl.sh
./db-dl.sh
cd ..

echo "Setup done!"
