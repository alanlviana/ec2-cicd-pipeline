#!/bin/bash
sudo apt-get update
sudo apt-get install -y python3
sudo apt install ruby-full
sudo apt install wget
cd /home/ubuntu

wget https://aws-codedeploy-${var.region}.s3.${var.region}.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
systemctl start codedeploy-agent
systemctl enable codedeploy-agent
