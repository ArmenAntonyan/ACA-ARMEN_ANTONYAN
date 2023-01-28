#!/bin/bash

x=1

while read -r line; do
echo "line $x $line"

(( x ++))

done < jamp.sh