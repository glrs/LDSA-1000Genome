#!/usr/bin/env python

import sys

current_word = None
word = None
count = 0

for line in sys.stdin:
    
    line = line.strip()
    word, count = line.split('\t')
    count = int(count)
    if word == current_word:
        current_count += count
    else:
        # False if current_word==None
        if current_word:
            print "%s\t%s" % (current_word, current_count)
        current_count = count
        current_word = word
if current_word == word:
    print "%s\t%s" % (current_word, current_count)
