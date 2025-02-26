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