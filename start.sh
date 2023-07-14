#!/usr/bin/env bash

# Start redis-server
systemctl start redis-server

# Start the DataServer
nohup python3 ./data_server/data_server.py &

# Start the Fake Syslog Gen Script
nohup python3 ./data_server/random_syslog_gen.py &

# Start the Map Server
nohup python3 ./map_server/map_server.py &