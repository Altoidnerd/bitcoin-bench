#!/usr/bin/env python3
# An example to generate a plot like the one in readme

import matplotlib.pyplot as plt

blocks, timestamps = [], []

# Before you parse a data file, it is wise to scape
# the irregular metadata out so parsing is easier.
# plot.input is just the log file in ../ without
# the irregular header and footer

f=open('plot.input', 'r')
flines=f.readlines()

for k in range(len(flines)):
    blocks.append(flines[k].split()[1])

for j in range(len(flines)):
    timestamps.append(flines[j].split()[7])

plt.plot(timestamps,blocks)
plt.title("blockcount vs time during blockchain sync with 0.12rc")
plt.xlabel("time in seconds (arbitrary offset)")
plt.ylabel("getblockcount during sync")
plt.show()


