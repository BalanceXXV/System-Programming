#!/bin/bash

line_break () {
	symbol=$1
	length=$2
	line=""
	for (( i=0; i<$length; i++ ))
	do
		line="$line$symbol"
	done
	echo "$line"
}

main_menu () {
	line_break "=" "20"
	echo "      Main Menu      "
	line_break "=" "20"
	echo "1. Operating System Info"
	echo "2. Hardware List"
	echo "3. Free and Used Memory"
	echo "4. Hardware Detail"
	echo "5. Exit"
	read -p "Choose 1-5 : " retval
}

os_info () {
	line_break "-" "55"
	echo "     System Status"
	line_break "-" "55"
	echo "Username : $USER"
	os=$(uname -a | awk -F ' ' '{print $1" "$3}')
	echo "OS : $os"
	uptime=$(uptime | awk -F '( |,)' '{print $8", "$4}')
	echo "Uptime : $uptime"
	ipAddr=$(ip addr show eth0 | grep -G 'inet ' | awk -F ' ' '{print $2}')
	echo "IP : $ipAddr"
	echo "Hostname : $HOSTNAME"
}

hardware_info () {
	line_break "-"  "55"
	echo "     Hardware List"
	line_break "-" "55"
	echo "Machine Hardware : $(uname -m)"
	hwList=$(lshw -short)
	printf "$hwList\n"
}

memory_info  () {
	line_break "-" "55"
	echo "     MEMORY"
	line_break "-" "55"
	line_break "*" "16"
	echo "     Memory"
	line_break "*" "16"
	memSize=$(free | grep "Mem" | awk -F ' ' '{print $2}')
	memFree=$(free | grep "Mem" | awk -F ' ' '{print $4}')
	echo "Size : $memSize MB"
	echo "Free : $memFree MB"
	line_break "*" "27"
	echo "     Memory Statistics"
	line_break "*" "27"
	vmstat=$(vmstat)
	printf "$vmstat\n"
	line_break "*" "35"
	echo "     Top 10 cpu eating process"
	line_break "*" "35"
	procList=$(ps aux k-pcpu | head -11)
	echo "$procList"
}

hardware_detail () {
	while :
	do
		line_break "=" "20"
		echo "     Hardware Detail"
		line_break "=" "20"
		echo "1. CPU"
		echo "2. Block Devices"
		echo "3. Back"
		read -p "Choose 1-3 :" input
		case "$input" in
			"1")
				cpu_info
				break
				;;
			"2")
				block_device
				break
				;;
			"3")
				break
				;;
			*)
				echo "Wrong Input!"
				;;
		esac
	done
}

cpu_info () {
	line_break "-" "55"
	echo "     CPU"
	line_break "-" "55"
	model_name=$(cat /proc/cpuinfo | grep "model name" | awk -F ':' '{print $2}')
	echo "Model Name :" $model_name
	frequency=$(cat /proc/cpuinfo | grep 'cpu MHz' | awk -F ':' '{print $2}')
	echo "Frequency :" $frequency
	cache=$(cat /proc/cpuinfo | grep 'cache size' | awk -F ':' '{print $2}')
	echo "Cache :" $cache
}

block_device () {
	line_break "-" "55"
	echo "     blk"
	line_break "-" "55"
	blk=$(lsblk)
	printf "$blk\n"
}

echo $(date)
while :
do
	main_menu
	case  "$retval" in
		"1")
			os_info
			;;
		"2")
			hardware_info
			;;
		"3")
			memory_info
			;;
		"4")
			hardware_detail
			;;
        	"5")
                	echo "Bye Bye...."
        		exit 0
			;;
		*)
			echo "Wrong Input!"
			;;
	esac
done
