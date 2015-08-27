#!/bin/bash

stime=$(date -d "$1" +%s)
for dir in /var/db/pkg/*/* ; do
    if [ -f $dir/BUILD_TIME ] ; then
        btime=$(<$dir/BUILD_TIME)
        if [ $btime -ge $stime ] ; then
            package=$(basename $dir)
            category=$(basename $(dirname $dir))
            echo $category/$package
        fi
    fi
done
