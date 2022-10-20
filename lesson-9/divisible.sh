#!/bin/bash

s="divisible in 7"
f="divisible in 5"
t="divisible in 3"
n="not divisible"
u="use only integer"
      echo "input value and i will tell you its divisible 7 or 5 or 3 or not"

read -p "" value

if  [[ $value != ?(-)+([0-9]) ]]
  then
        echo "${u}"

        bash ./divisible.sh 
elif [ `echo $value/7*7 | bc` -eq $value ]
  then
        echo "${s}"
elif [ `expr $value % 5` -eq 0 ]
  then
        echo "${f}"
elif [ `echo  $value/3*3 | bc` -eq $value ]
  then
        echo "${t}"
  else
        echo "${n}"
 fi 
