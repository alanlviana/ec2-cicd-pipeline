#!/bin/bash
set -e

echo "Validating app service..."

# Wait for the app to start
sleep 5

# Health check (assuming app runs on port 80)
curl -f http://localhost:80 || {
    echo "App validation failed."
    exit 1
}

echo "App is running correctly."