#!/bin/bash
apt update -y
apt install nginx -y
echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.
echo fin v1.00!
