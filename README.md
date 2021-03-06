# Usage, explanation and installation #
-------
### IndexInfo 
IndexInfo contains the script that generates information about the Pi and runs the other scripts. 
It generates information about CPU, current date, harddisk and RAM usage.

### JSONlog 
JSONlog is used to log the information, generated by IndexInfo to a JSON file. You can set how many
entries your JSON file can have.

### Webcam  
Webcam is a very simple script that just uses the 'fswebcam'  program to capture a picture with the 
primary webcam that is connected to your Pi.

### PyStats 
This script makes a visual representation of whatever data is stored into your JSON file. It does this
using 'matplotlib'. It generates two images with the data of CPU and temperature of the system. An alternative
method is using d3 to draw these graphs. If you do choose d3 over Python, than it is best to disable the 
PyStats script in IndexInfo.

### Site 
Site is an example of how you can implement the data in these scripts into a website. Most of the information
is visualised with PHP, but the statistics can be done either by d3 or Python. Take a look in the 'js' folder
and either include the 'pythonstats.js' or 'stats.js' in your 'history.html' file.

### Important 
All of these files contain settings with paths that need to be set. If you want to use a file, please check
if the paths are set correctly. If it still doesn't work afterwards, you can contact me and I'll try to help
you and set it up. 

### Crontab 
This script is ran by adding it to the crontab. To do so, you can run 'sudo crontab -e' and add the location
of your IndexInfo, and the frequency of when it should be ran to it.
