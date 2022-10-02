#!/bin/bash

while
   gax=60
 do
              echo -en '\n'
       echo "ինչ թիվ է մտ ա պ ա հվա ծ"
              echo -en '\n'
 read -p "" tiv
             echo -en '\n'
  if
     [ $tiv -gt $gax ]
    then
       echo "$tiv -ը մեծ  է  մ տ ա պ հ վ ա ծ թ վ ի ց"
              echo -en '\n'
   elif
     [ $tiv -lt $gax ]
    then
       echo "$tiv ֊ը փ ո ք ր  է  մ տ ա պ հ վ ա ծ թ վ ի ց "
               echo -en '\n'
   elif [ $tiv -eq $gax ]
    then
       echo "Դ ու   գ ու շ ա կ ե ց ի ր "
        break
   else 
       echo "Չ ե ս  ջ ո կ ե լ  ո ր  թ ի վ  ե մ  հ ա ր ց ն ու մ "
               echo -en '\n'
  fi
done
