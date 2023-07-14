#!/bin/bash

# Stop the Map Server
echo "Stopping Map Server..."
pkill -f map_server.py

# Stop the Fake Syslog Gen Script 
echo "Stopping Fake Syslog Gen Script..."
pkill -f random_syslog_gen.py

# Stop the DataServer
echo "Stopping DataServer..."  
pkill -f data_server.py

# Stop redis-server
echo "Stopping redis-server..."
systemctl stop redis-server
