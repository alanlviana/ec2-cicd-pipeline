#!/bin/bash
apt-get update
apt-get install -y python3

wget https://aws-codedeploy-${var.region}.s3.${var.region}.amazonaws.com/latest/install
chmod +x ./install
./install auto
systemctl start codedeploy-agent
systemctl enable codedeploy-agent

echo "Hello World from $(hostname)" > index.html
nohup python3 -m http.server 80 &