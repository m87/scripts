#!/bin/bash

thread="$(echo $1 | grep -o "[0-9]*$")"
mkdir $thread
c=0
declare -a names
declare -a links
for name in $(curl  $1 | grep -P -o 'File: <a href="//i.4cdn.org.*? target="_blank">.*?</a>' | grep -P -o '_blank">.*?<' | sed 's/^........//' | sed 's/.$//' | tr ' ' '_')
do
 names[c]=$name
 c=$(($c+1))
done

c=0
for link in $(curl $1 | grep -P -o 'File: <a href="//i.4cdn.org.*? target="_blank">.*?</a>' | grep -P -o '//.*?"' | sed 's/^..//' | sed 's/.$//' )
do
 links[c]=$link
 c=$(($c+1))
done

total=${#links[@]}
total2=${#names[@]}

echo $total2
echo $total

if [[ $total != $total2 ]]; 
then
    echo "ERROR"
    exit
fi

counter=1
for link in ${links[*]}
do
    echo -n Downloading image $counter of $total...
     
    wget --no-check-certificate -q -nc $link -O $thread/${names[$counter-1]}
    echo ' Done'
    counter=$(($counter+1))
done

