#!/usr/bin/env bash

# Start redis-server
systemctl start redis-server

# Start the DataServer
cd ./data_server
nohup python3 ./data_server.py &

# Start the Fake Syslog Gen Script
nohup python3 ./random_syslog_gen.py &
cd ..

# Start the Map Server
cd ./map_server
nohup python3 ./map_server.py &