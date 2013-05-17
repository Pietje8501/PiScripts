###################################
# This script is not made for     #
# error - checking the input nor  #
# checking the existing JSON file.#
# If the file or input wasn't     #
# valid, this won't change it.    #
###################################
#!/bin/bash
# Check the arguments
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
