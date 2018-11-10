#!/bin/sh

get_pids () {
	echo Your PID is $$
}
trap "get_pids" USR1
while [ 1 -gt 0 ]
do 
	echo Running....
	sleep 2
done
