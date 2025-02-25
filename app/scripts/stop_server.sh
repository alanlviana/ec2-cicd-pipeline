#!/bin/bash

echo "Stopping Python app..."

# Find and kill the app process
APP_PID=$(pgrep -f "python app.py")
if [ -n "$APP_PID" ]; then
    kill -9 $APP_PID
    echo "App stopped."
else
    echo "No running app found."
fi
