<?php
header('Content-type: text/html; charset=utf8');
# Read data to array of lines
$file = "data/system.txt";
$lines = file($file);

# Read gradient image
$grad = ImageCreateFromJPEG("images/gradient.jpg");

# Get content out of array
$temp = trim($lines[0]);
$cpu = trim($lines[1]);
$allram = trim($lines[2]);
$freeram = trim($lines[3]);
$uptime = trim($lines[4]);
$alldisc = trim($lines[5]);
$useddisc = trim($lines[6]);

# Make the background image
$image = ImageCreate(400,200);

# Define the colors
$white = ImageColorAllocate($image, 255, 255, 255);
$black = ImageColorAllocate($image, 0, 0, 0);

#Fill the background up
$background = ImageColorAllocate($image, 47, 79, 79);
ImageFill($image, 0, 0, $background);

#Add the text to the image
ImageString($image, 3, 40, 10, "CPU verbruik (vorige 15min): ".$cpu."%", $white); 
ImageString($image, 3, 40, 45, "Huidige temperatuur: ".$temp."°C", $white);
ImageString($image, 3, 40, 80, "RAM Geheugen: ".$freeram."MB van de ".$allram."MB beschikbaar", $white);
ImageString($image, 3, 40, 120, "Gebruik HD: ".$useddisc."MB van de ".$alldisc."MB gebruikt", $white); 
ImageString($image, 3, 40, 160, "Totale uptime: ".$uptime, $white);

# Add the bars
# First up: RAM memory
$used = ($allram-$freeram)/$allram;
ImageFilledRectangle($image, 90, 100, 340, 110, $black);
ImageCopy($image, $grad, 90, 100, 0, 0, $used*250, 10);
ImageString($image, 3, 95, 98, round($used*100)."%", $white);

#Secondly: disk usage
$used = ($useddisc/$alldisc);
ImageFilledRectangle($image, 90, 140, 340, 150, $black);
ImageCopy($image, $grad, 90, 140, 0, 0, $used*250, 10);
ImageString($image, 3, 95, 138, round($used*100)."%", $white);

ImagePng($image);
?>
