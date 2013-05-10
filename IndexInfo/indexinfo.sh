####################################
# This script generates some       #
# information about the current    #
# system                           #
####################################
#!/bin/bash
indexfile='/var/www/index.html'

echo '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="style.css" >
<title>Raspberry Pi Info</title>
</head>
<body>
<div id="logo">
</div>
<div id="main">
<div id="info">' > $indexfile

temp=$(/opt/vc/bin/vcgencmd measure_temp | sed 's/.*=//' | sed "s/'/\&deg;/")
echo "De huidige temperatuur bedraagt: "$temp >> $indexfile
echo "</div>" >> $indexfile

echo '<div id="load">' >> $indexfile
cpuload=$(cat /proc/loadavg | awk '{ print $3"&#37;" }')
echo "De gemiddelde CPU-load in de vorige 15min bedroeg: "$cpuload"<br>" >> $indexfile
ramtotal=$(cat /proc/meminfo | awk 'NR==1 { print int($(NF-1)/1024)"MB" }')
ramfree=$(cat /proc/meminfo | awk 'NR==2 { print int($(NF-1)/1024)"MB" }')
echo "Er is nog "$ramfree" van de "$ramtotal" geheugen vrij" >> $indexfile
echo "</div>" >> $indexfile

echo '<div id="uptime">' >> $indexfile
uptime=$(uptime | awk ' { print $3 } ' | sed 's/,//')
echo "Het systeem is al "$uptime" online" >> $indexfile
echo "</div>" >> $indexfile

echo '</div>
</body>
</html>' >> $indexfile

