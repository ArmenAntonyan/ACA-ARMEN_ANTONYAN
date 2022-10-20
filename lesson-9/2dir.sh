#!/bin/bash
o=odd
e=even
f="bajanvum e 2"
n="chi bajanvum 2 i"

mkdir ./"${o}" "${e}" 

for d in {1..20}; do

 if [ `expr $d % 2` -eq 0 ]
   then
        touch "./${e}/${d}.txt"
   else 
        touch "./${o}/${d}.txt"
 fi

done
echo "I created the files in the relevant folders"
