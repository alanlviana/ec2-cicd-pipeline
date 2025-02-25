#!/bin/bash
set -e

echo "Starting Python app..."

cd /home/ec2-user/app
source venv/bin/activate

# Run the app (assumes Flask)
nohup python app.py > app.log 2>&1 &

echo "App started successfully."