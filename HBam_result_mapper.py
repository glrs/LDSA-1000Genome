#!/usr/bin/env python
import sys

for line in sys.stdin:
	words = line.split()
	word = words[0].split(".")[0]
	print "%s\t 1" % word
