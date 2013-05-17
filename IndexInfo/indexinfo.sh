####################################
# This script generates some       #
# information about the current    #
# system                           #
####################################
#!/bin/bash
statsfile='/var/www/data/system.txt'
chartfile='/var/www/data/chart.json'

# Calculate temperature
temp=$(/opt/vc/bin/vcgencmd measure_temp | sed 's/.*=//' | sed "s/'.*//")
echo $temp > $statsfile
jtemp='"temp":'$temp','

# Calculate CPU load
cpuload=$(cat /proc/loadavg | awk '{ print $3 }')
echo $cpuload >> $statsfile
jcpu='"cpu":'$cpuload','

# Calculate total and available RAM
ramtotal=$(cat /proc/meminfo | awk 'NR==1 { print int($(NF-1)/1024) }')
echo $ramtotal >> $statsfile
ramfree=$(cat /proc/meminfo | awk 'NR==2 { print int($(NF-1)/1024) }')
echo $ramfree >> $statsfile

# Display current uptime
uptime=$(uptime | sed 's/.*up //' | sed 's/,[ \t]*[0-9][ \t]*user.*$//')
echo $uptime >> $statsfile

# Display total disk / disk usage
totaldisk=$(df | awk 'NR==2 { print int($2/1024) }')
echo $totaldisk >> $statsfile
useddisk=$(df | awk 'NR==2 { print int($3/1024) }')
echo $useddisk >> $statsfile

# Add timestamp and other info to JSON file
jdate='"date":"'$(date)'"'
sh /home/pi/scripts/jsonlog.sh $chartfile "$jtemp" "$jcpu" "$jdate"

# Update cam picture
sh /home/pi/scripts/makepicture.sh
