# In the Name of God, the Originator the Creative

# Use Python 3.7 as base image
FROM python:3.7

# Install system dependencies
RUN apt-get update && apt-get install -y redis-server wget rsyslog

# Set working directory  
WORKDIR /app

# Copy project files
COPY requirements.txt ./
COPY data_server/ ./data_server/
COPY DB/ ./DB/
COPY map_server/ ./map_server/

# Configure DataServer DB  
RUN cd ./DB && ./db-dl.sh && cd ..

# Install Python dependencies
RUN pip install -U -r requirements.txt

# Expose ports
EXPOSE 6379 8888

# Start services
CMD nohup service redis-server start & \
  nohup python3 data_server/random_syslog_gen.py & \
  nohup python3 data_server/data_server.py & \
  python3 map_server/map_server.py