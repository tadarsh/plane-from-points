'''
Converts csv file to ply file
Usage:
    python csv2ply.py <csv-file> <ply-file>
'''

import sys
import numpy as np

data = open(sys.argv[1], 'r').readlines()
default_ply = open("template/ply_default.ply", 'r').readlines()
fout = open(sys.argv[2], 'w')
N = len(data)
for i in xrange(len(default_ply)):
    if i == 3:
        st = default_ply[i].rstrip().split(' ')
        st[2] = str(N)  
        default_ply[i] = st[0] + " " + st[1] + " " + st[2] + "\n" 
    fout.write("%s"%default_ply[i])
for i in xrange(len(data)):
    st = data[i].rstrip().split(',')
    for j in xrange(len(st)):
        if j != len(st) - 1:
            fout.write("%s "%st[j]) 
        else:
            fout.write("%s\n"%st[j])
fout.close()





