#!/bin/bash
sudo apt-get update
sudo apt-get install -y python3
sudo apt install ruby-full -y
sudo apt install wget -y
cd /home/ubuntu

wget https://aws-codedeploy-sa-east-1.s3.sa-east-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo systemctl start codedeploy-agent
sudo systemctl enable codedeploy-agent
