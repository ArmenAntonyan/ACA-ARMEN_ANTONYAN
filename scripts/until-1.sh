#!/bin/bash

until [[ $order == "coffee" ]]
 do
  echo "would you like coffee or tea?"
   read order
 done
  echo "exelent, here is your coffe"
