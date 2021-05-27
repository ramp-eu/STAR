#!/bin/bash
sed -e "s/FIWAREHOST/$FIWAREHOST/g" 
echo $FIWAREHOST
sleep 5
ip=$FIWAREHOST
id="StitchJob"

csvfile="app/data.csv"
echo DOING : curl create entities
#make sure you execute this line only once, comment if you need to update existing entities
./createcsv.sh $csvfile
echo DOING : curl get entities
curl --location --request GET $ip:1026/v2/entities # | json_pp

x=1
while [ 1 ]
do
  echo "Welcome $x times"
  x=$(( $x + 1 ))
	sleep 1
	echo DOING : upload csv
  ./updatecsv.sh $csvfile
	echo DOING : curl get entities only jobid
	curl --location --request GET $ip:1026/v2/entities/$id/attrs/JobID #| json_pp
done

