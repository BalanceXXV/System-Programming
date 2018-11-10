#!/bin/bash

arg1=$(echo $1 | cut -d'=' -f2)
X=$(echo $1 | cut -d'=' -f1)
arg2=$(echo $2 | cut -d'=' -f2)
Y=$(echo $2 | cut -d'=' -f1)

result=$((arg1+arg2))
printf "%s+%s=%s\n" "$X" "$Y" "$result"
