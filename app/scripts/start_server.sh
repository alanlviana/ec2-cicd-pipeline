#!/bin/bash
set -e

# Create virtual environment
cd /home/ubuntu/app
virtualenv venv
source venv/bin/activate

# Install app dependencies
pip install -r requirements.txt

echo "Dependencies installed."

echo "Starting Python app..."

# Run the app (assumes Flask)
nohup python app.py > app.log 2>&1 &

echo "App started successfully."