import re

with open('file.txt', 'r') as f:
    for line in f:
        cols = line.split()
        if re.search('Ripley', cols[0]):
            print(cols[1])
