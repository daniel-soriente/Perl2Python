#!/usr/bin/python2.7 -u
import sys
# written by andrewt@cse.unsw.edu.au as a COMP2041 lecture example
# Count the number of lines on standard input.

line = ""
line_count = 0
for line in sys.stdin:
	line_count += 1
print line_count lines
