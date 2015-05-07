#!/usr/bin/python3
import csv
import sys

def parse_file(in_file):
    text = in_file.read()
    text = text.strip()
    lines = text.split('\n')
    to_return = []
    
    for l in lines:
        current_line = []
        l = l.strip()
        numbers = l.split(' ')
        for n in numbers:
            current_line.append(float(n))
        to_return.append(current_line)        
    return to_return

def convert_to_csv(data, out_file):
    for l in data:
        for i in range(6):
            if i < 5:
                out_file.write(str(l[i]) + ',')
            if i == 5:
                out_file.write(str(l[i]) + '\n')

if __name__ == '__main__':
    file_name = sys.argv[1]
    print('Print the file name ', file_name, '\n')
    in_file = open(file_name, 'r')
    data = parse_file(in_file)
    print(data)

    out_file = open(sys.argv[2], 'w')
    convert_to_csv(data, out_file)
    out_file.close()
