#!/usr/bin/env bash

# Start redis-server
pm2 start redis-server --interpreter="none"  -- --port 6380 -- --protected-mode no

# Start the DataServer
cd ./data_server
pm2 start ./data_server.py --interpreter=python3

# Start the Map Server
cd ../map_server
pm2 start ./map_server.py --interpreter=python3
pm2 save