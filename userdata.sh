#!/bin/bash
set -e
sudo yum update -y
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 590184134827.dkr.ecr.ap-south-1.amazonaws.com