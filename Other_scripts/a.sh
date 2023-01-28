#!/bin/bash

x=path

echo "Enter the $x name: "

read path

for x  in $path

  do

  if [ -d "$x" ]

then
  echo "$x is path <<directory>>" >> path.txt

  elif [ -f "$x" ]

then
  echo "$x is file " >> file.txt
else

  echo "$x is not directory or file" >> error.txt
fi

done 

