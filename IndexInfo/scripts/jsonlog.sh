###################################
# This script is not made for     #
# error - checking the input nor  #
# checking the existing JSON file.#
# If the file or input wasn't     #
# valid, this won't change it.    #
###################################
#!/bin/bash
# Check the arguments

# Maximum number of entries in the JSON file
maximum=100

if [ "$#" -lt 2 ]
then
	echo "Usage: $(basename $0) file line1 line2"
	exit 0
fi

# Check if specified file exists
if [ ! -f $1 ]
then
	echo "Usage: $(basename $0) file line1 line2"
	echo "The file '$1' doesn't exist."
	exit 0
fi

# Check if this is an empty file and prepare the file for data insertion
if [ "$(wc -l < $1)" -eq "0" ]
then
	# Initialize this new file as JSON file
	echo "[" >> $1
	echo "]" >> $1
else
	# Check last line if it contains an ending ']'
	if [ "$(tail -1 $1)" != "]" ]
	then
		echo "File doesn't seem to have the right syntax"
		echo "Last line doesn't end in ']'; $(tail -1 $1)"
		exit 0
	fi
fi

# Count the number of occurences
entra=$(fgrep -o "{" $1 | wc -l)
entrb=$(fgrep -o "}" $1 | wc -l)
todelete=$(($entra - $maximum))

if [ ! "$entra" -eq "$entrb" ]
then
	echo "Number of start tags is not the same as number"
	echo "of end tags. Start: '$entra', end: '$entrb'" 
	exit 0
fi

# Remove older entries if number of entries exceeds minimum
if [ "$todelete" -gt "0" ]
then
	awk -v del=$todelete '
	BEGIN{start=0; end=0; print "["}
	{
	if( match($0, "{") > 0)start++
	if( match($0, "},") > 0)end++
	if( (start > del+1) && (end > del)){
		print $0
	 }
	}' $1 > tmpchartdata
	mv tmpchartdata $1
fi

# Insert all the data into the JSON file
# The script inserts all arguments, but the first before the last line
# with sed -i, and separates data with a comma
file=$1
metachar="###"
sed -i '$i{' $file
while [ "$#" -gt 1 ];do
	arg=$(echo $2 | sed 's/ /\\ /g')
	sed -i "\$i$arg" $file
	shift
done
sed -i '$i}'$metachar $file
sed -i 's/^[ \t]*\}$/\},/g' $file
sed -i 's/'$metachar'//g' $file
