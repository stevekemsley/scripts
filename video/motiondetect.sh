#!/bin/bash

cd wildlifecam

files=$(ls)

for result in $files 
do

#dvr-scan -i $result --threshold 0.50 -b CNT -m copy
dvr-scan -i $result --threshold 0.50 -m copy

done

exit 0
