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
data = data.drop([length - 1, length - 2])

sizes = []
for i in range(0, len(data)):
    sizes.append(marker_size)

fig = plt.figure()
ax1 = fig.add_subplot(211)
ax1.scatter(data['time'], data['EPtot'], sizes)
ax1.set_ylabel("EPtot")
ax1.set_xlabel("Time")

ax2 = fig.add_subplot(212)
ax2.scatter(data['time'], data['temp'], sizes)
ax2.set_ylabel("Temperature")
ax2.set_xlabel("Time")
plt.show()