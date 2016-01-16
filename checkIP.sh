#!/bin/bash
#checks to see 192.168.*

for n in {100..200};do
    host=192.168.84.$n
    ping -c2 $host &>/dev/null 
    if [ $? = 0 ]; then
        echo "$host is up"
    else
        echo "$host is down"
    fi
done
