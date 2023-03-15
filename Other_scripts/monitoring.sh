#!/bin/bash

service nginx status > manitoring.txt

if grep -q "running" manitoring.txt

echo "the service is running"

else
 
service nginx start

echo "the service is stopped, error or inactive, service has benn started"

fi

rm -rf monitoring.txt
