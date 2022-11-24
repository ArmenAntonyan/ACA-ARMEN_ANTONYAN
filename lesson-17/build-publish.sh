#!/bin/bash

if [ -z $1 ]
  then
    echo "u must input 4 arguments` username password image_repository_name image_tag "
  exit 1

 elif [ -z $2 ]
  then
   echo "u must input 4 arguments` username password image_repository_name image_tag "
  exit 1

 elif [ -z $3 ]
  then
   echo "u must input 4 arguments` username password image_repository_name image_tag "
  exit 1

 elif [ -z $4 ]
  then
   echo "u must input 4 arguments` username password image_repository_name image_tag "
  exit 1

fi


docker login -u $1 -p $2  

docker image build -t $3 .

docker push $4
