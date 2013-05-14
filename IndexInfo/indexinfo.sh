####################################
# This script generates some       #
# information about the current    #
# system                           #
####################################
#!/bin/bash
statsfile='/var/www/data/system.txt'

temp=$(/opt/vc/bin/vcgencmd measure_temp | sed 's/.*=//' | sed "s/'.*//")
echo $temp > $statsfile

cpuload=$(cat /proc/loadavg | awk '{ print $3 }')
echo $cpuload >> $statsfile

ramtotal=$(cat /proc/meminfo | awk 'NR==1 { print int($(NF-1)/1024) }')
echo $ramtotal >> $statsfile
ramfree=$(cat /proc/meminfo | awk 'NR==2 { print int($(NF-1)/1024) }')
echo $ramfree >> $statsfile

uptime=$(uptime | sed 's/.*up //' | sed 's/,[ \t]*[0-9][ \t]*user.*$//')
echo $uptime >> $statsfile

totaldisk=$(df | awk 'NR==2 { print int($2/1024) }')
echo $totaldisk >> $statsfile
useddisk=$(df | awk 'NR==2 { print int($3/1024) }')
echo $useddisk >> $statsfile

sh /home/pi/scripts/makepicture.sh
