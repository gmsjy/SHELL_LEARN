#!/bin/bash
#script to capture system statistics

OUTFILE=/root/capstats.csv
DATE='date +%m/%d/%y'
Time='date +%k:%m:%s'
TIMEOUT='uptime'
VMOUT='vmstat 1 2'
