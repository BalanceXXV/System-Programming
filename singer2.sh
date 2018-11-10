#!/bin/sh

ready () {
	if [ ! -w pid.file ]
	then
		touch pid.file
	fi
	echo "ready $$" > pid.file
}
check_pid(){
	read -r file < pid.file
	partner=$file
	line=0
	kill -USR1 $partner
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
        while [ $count -lt ${#turn[@]} ] && [ "${turn[$count]}" != "2" ]
        do
                count=$(($count+1))
        done
        while [ $count -lt ${#turn[@]} ] && [ "${turn[$count]}" == "2" ]
        do
                echo ${lyric[$count]}
                count=$(($count+1))
                if [ "${turn[$count]}" == "2" ]
                then
                        sleep 1
                fi

        done
        line=$(($count+$line))
        kill -USR1 $partner
}

trap "check_pid" USR1
trap "sing" USR2
text="lyrics.txt"
ready
while [ 1 -gt 0 ]
do
	echo ...
	sleep 1
done

