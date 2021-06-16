#!/bin/bash

##sudo yum -y update
sudo amazon-linux-extras install -y  nginx1

sudo systemctl start nginx
sudo systemctl enable nginx


##sudo apt-get update
##sudo apt-get install -y nginx
##sudo systemctl start nginx
##sudo systemctl enable nginx
##sudo ufw allow 'nginx full'
##sudo ufw reload  

