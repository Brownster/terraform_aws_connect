#!/bin/bash
sudo apt update -y
sudo apt install -y apache2
echo "<h1>Terraform Setup Complete</h1>" | sudo tee /var/www/html/index.html
sudo systemctl restart apache2
