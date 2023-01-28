#!/bin.bash

for x in edupolice.am police.am moodle.edupolice.am 
 do 
  if ping -q -c 2 -W 1 $x > /dev/null; then
   echo "$x is up"
  else
   echo "$x is down"
  fi 
done
