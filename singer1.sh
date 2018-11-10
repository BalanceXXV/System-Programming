#!/bin/sh

store_pid () {
	if [ ! -w pid.file ]
	then	
		touch pid.file
	fi
	echo $$ > pid.file
}
check_pid () {
	read file < pid.file
	status=$(echo $file | cut -f1 -d' ')
	if [ "$status" == "ready" ]
	then
		partner=$(echo $file | cut -f2 -d" ")
		store_pid
		kill -USR1 $partner
		start="true"
		line=0
	fi
}
sing(){
	IFS=$'\n'
	turn=($(cat $text | awk "NR > $line" | awk -F '$' '{printf $1"\n"}'))
	lyric=($(cat $text | awk "NR > $line" | awk -F '$' '{printf $2"\n"}'))
	count=0
	if [ ${#turn[@]} -le 0 ]
	then
		kill -13 $partner
		exit
	fi
	while [ $count -lt ${#turn[@]} ] && [ "${turn[$count]}" != "1" ]
	do	
		count=$(($count+1))
	done
	while [ $count -lt ${#turn[@]} ] && [ "${turn[$count]}" == "1" ]
	do
		echo ${lyric[$count]}
		count=$(($count+1))
		if [ "${turn[$count]}" == "1" ]
		then
			sleep 1
		fi
	done
	line=$(($count+$line))
	kill -USR2 $partner
}

trap "sing" USR1 
start="false"
text="lyrics.txt"
while [ 1 -gt 0 ]
do
	if [ $start ==  "false" ]
	then
		check_pid
	fi
	echo ...
	sleep 1
done
