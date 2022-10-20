#!/bin/bash
e="........ERROR....... "
p="please enter the characters between 8-32"
u="use only integer"
d="dis is your pass"
l="enter the length of password for you"

echo "$l"

read -p  "" pass

if  [[ "${pass}" != ?(-)+([0-9]) ]]
  then
        echo "${u}"

        bash ./pass.sh 

elif [ "${pass}" -lt 8 ] || [ "${pass}" -gt 32 ]; then 

   echo "$e"
   echo "$p"
else
   cat /dev/urandom | tr -dc A-Za-z0-9 | head -c "${pass}"
   echo -en '\n'
   echo "$d"

fi
