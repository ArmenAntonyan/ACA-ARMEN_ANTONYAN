#!/bin/bash

names=("Babken" "Armen" "Arthur" "Khachik" "Nella")
for ((i = 0; i < ${#names[@]}; i++))
do
    echo ${i} '=>' ${names[$i]}
done
