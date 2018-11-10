#!/bin/bash

read -r pidfile < pid.file
echo -n "Enter some text > "
read text
echo $text > file.read

kill -USR1 $pidfile
