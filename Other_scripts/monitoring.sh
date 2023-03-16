#!/bin/bash

echo "write name of service which ypu wont monitor"

read -p "" service

service nginx status > $service.txt

if grep -q "running" $service.txt

echo "the $service is running"

else
 
service $service start

echo "the $service is stopped, error or inactive, service has benn 
started"

fi

rm -rf monitoring.txt
