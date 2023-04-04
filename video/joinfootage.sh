#!/bin/bash

cd wildlifecam

rm clips.txt &> /dev/null
rm clips.mp4 &> /dev/null


files=$(ls)



#prepare a clips file
for result in $files 
do

	echo "file '$result'" >> clips.txt

done

#use ffmpeg to join

ffmpeg -safe 0 -f concat -i clips.txt -c copy clips.mp4

exit 0
