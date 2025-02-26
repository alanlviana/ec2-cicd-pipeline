#!/bin/bash
set -e

echo "Installing Python and dependencies..."

# Install Python and pip if not present
if ! command -v python3 &> /dev/null
then
    sudo apt install -y python3
fi

# Install virtualenv if not installed
if ! command -v virtualenv &> /dev/null
then
    sudo apt install -y python3-virtualenv 
fi

# Create virtual environment
cd /home/ubuntu/app
virtualenv venv
source venv/bin/activate

# Install app dependencies
pip install -r requirements.txt

echo "Dependencies installed."
