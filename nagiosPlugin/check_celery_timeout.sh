#!/bin/bash
#check celeryworker timeout 3s in one hour over 500

STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3   

limit=500
flag=0
time_now=`date +%H.%M`
day_dir=`date +%Y%m%d`
log_dir=/opt/typhoonae/var/log
time_ago=`date +%H.%M  --date="-1 hour" `
state=`/bin/cat /opt/typhoonae/var/log/celeryd.log* | awk '{if ( $9 ~ /cost/ && $10>3) print $2 " " $5 }'| awk 'BEGIN{FS=":"}{print $1"."$2" "$4}'|awk '{if ( $1>a && $1<b) print $2}' a=$time_ago b=$time_now | sort | uniq -c`

for word in $state
do
      if [[ $word -gt $limit ]];then
             flag=1
              fi
          done
         
         case $flag in
             0)
                  echo "celery workers is OK!" $state
                   exit $STATE_OK
                    ;;
                   
                1)
                     echo "   celeryworkers timeout! " $state
                      exit $STATE_CRITICAL
                       ;;
                      
                      
               esac 
