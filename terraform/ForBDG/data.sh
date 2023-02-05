#!/bin/bash
apt-get -y update
apt-get -y install apache2
echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
echo "fin v1.00!"
