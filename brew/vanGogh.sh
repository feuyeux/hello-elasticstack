#!/bin/sh
#
# vanGogh script.
# 2016.12.21
#

scriptPath=$(cd $(dirname $0);pwd)
cd $scriptPath
mkdir logs  2>/dev/null && touch vanGogh.log

messages=("Vincent" "Eric" "Paul" "Michael" "Kevin" "Sam" "Bill")
i=1
while [ ${i} -le 60 ]
do
  vanId=$RANDOM
  timestamp=$(date +%s)
  time=$(date +%Y%m%d-%H%M)
  n=$((RANDOM % ${#messages[@]} ))
  echo "${time}|${vanId}|${timestamp}|$n|hello ${messages[$n]}!" >>logs/vanGogh.log
  sleep 1s 
  ((i++))
done