#!/usr/bin/env python

try:
    import simplejson as json
except ImportError:
    import json
import matplotlib as mpl
mpl.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.dates import HourLocator, DateFormatter
from datetime import datetime

# A few settings
file = "/var/www/data/chart.json"
imgpath = "/var/www/images/"

# Load JSON data
json_data = open(file)
json = json.load(json_data)

# Extraction of data
date = []
temp = []
cpu = []

for d in json:
    date.append(datetime.strptime(d["date"], "%a %b %d %H:%M:%S %Z %Y"))
    temp.append(d["temp"])
    cpu.append(d["cpu"])

json_data.close()

# Construction of graph
hours = HourLocator(interval=4)
hoursfmt = DateFormatter("%a %H h")

fig = plt.figure(figsize=(5,2), dpi=100)
fig.set_facecolor('#2F4F4F')
ax = plt.gca()
ax.xaxis.set_major_locator(hours)
ax.xaxis.set_major_formatter(hoursfmt)
plt.tick_params(axis='both', which='major', labelsize=8, colors='white')
plt.plot(date, temp)
fig.autofmt_xdate()
plt.savefig(imgpath+"charttemp.png",facecolor=fig.get_facecolor(), edgecolor='none')

fig = plt.figure(figsize=(5,2), dpi=100)
fig.set_facecolor('#2F4F4F')
ax=plt.gca()
ax.xaxis.set_major_locator(hours)
ax.xaxis.set_major_formatter(hoursfmt)
ax.xaxis.label.set_color('white')
ax.yaxis.label.set_color('white')
plt.tick_params(axis='both', which='major', labelsize=8, colors='white')
plt.plot(date, cpu)
fig.autofmt_xdate()
plt.savefig(imgpath+"chartcpu.png",facecolor=fig.get_facecolor(), edgecolor='none')
