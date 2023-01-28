#!/bin/bash

x=1

while [[ $x -le 10 ]]
do
read -p "jamp $x: press enter to continue"
(( x  ++ ))
done

echo "whel done"
