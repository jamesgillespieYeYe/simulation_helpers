import numpy as np
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import sys

marker_size=.1
input_file = "final.csv"
title = "default title"
for arg in sys.argv:
    split = arg.split(':')
    if split[0] == '-i':
        input_file = split[1]
    elif split[0] == '-t':
        title = split[1]
print("Input file:", input_file, ",", "title: ", title)

data = pd.read_csv(input_file, ",")
length = len(data)
#Get rid of last two entries as they are from summary at end of file
data = data.drop([length - 1, length - 2])



minEnergy = 999
minStep = 0
minTime = 0
minIndex = 0
for i in range(0, len(data)):
    row = data.loc[i]
    energy = row['EPtot']
    step = row['step']
    time = row['time']
    if energy < minEnergy:
        minEnergy = energy
        minStep = step
        minTime = time
        minIndex = i
    
print("Minimum energy occurs at time:", minTime, "step:", minStep, "energy: ", minEnergy)


sizes = []
colors = []
for i in range(0, len(data)):
    if (i == minIndex):
        sizes.append(50)
        colors.append('red')
    else:
        sizes.append(marker_size)
        colors.append('blue')
    



fig = plt.figure()
ax1 = fig.add_subplot(211)
ax1.scatter(data['time'], data['EPtot'], sizes,c=colors)
ax1.set_ylabel("EPtot")
ax1.set_xlabel("Time")

ax2 = fig.add_subplot(212)
ax2.scatter(data['time'], data['temp'], sizes)
ax2.set_ylabel("Temperature")
ax2.set_xlabel("Time")


secondFig = plt.figure()
secondAx1 = secondFig.add_subplot(211)
secondAx2 = secondFig.add_subplot(212)
bound = 50
secondAx1.plot(data['time'][minIndex-bound:minIndex+bound], data['EPtot'][minIndex-bound:minIndex+bound])

secondAx2.plot(data['time'][minIndex-bound:minIndex+bound], data['temp'][minIndex-bound:minIndex+bound])


thirdFig = plt.figure()
ax = thirdFig.add_subplot(111)
ax.scatter(data['temp'], data['EPtot'])
plt.show()