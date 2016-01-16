#!/bin/bash 

#自动检测adsl重新拨号

while :

do
    if route | tail -l | grep "0.0.0.0"
    then
        &>/dev/null 
    else
        adsl-stop
        adsl-start
    fi
    sleep 10
done


