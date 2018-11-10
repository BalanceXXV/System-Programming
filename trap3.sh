echo $$ > pid.file
read_files(){
	read -r file < file.read
	echo $file
}
trap "read_files" TERM USR1
if [ ! -w pid.file ] 
then
	touch pid.file
fi
echo $$ > pid.file
while [ 1 -gt 0 ]
do
	echo Running....
	sleep 2
done
