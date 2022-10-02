#!/bin/bash

while
   gax=60
 do
       echo "ինչ թիվ է մտ ա պ ա հվա ծ"
 read -p "" tiv
  if
     [ $tiv -gt $gax ]
   then
       echo "$tiv -ը մեծ  է  մ տ ա պ հ վ ա ծ թ վ ի ց"
   elif
     [ $tiv -lt $gax ]
   then
       echo "$tiv ֊ը փ ո ք ր  է  մ տ ա պ հ վ ա ծ թ վ ի ց "
   elif [ $tiv -eq $gax ]
   then
       echo "Դ ու   գ ու շ ա կ ե ց ի ր "
 break
 fi
done
