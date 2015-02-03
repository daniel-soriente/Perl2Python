#!/usr/bin/python2.7 -u
import fileinput
import sys
# Test for Subset4 - <>, ., .=

string = ""
for line in fileinput.input():
	line = line.rstrip()
	string += line
	sys.stdout.write("%s" % (line))

print "%s" % (string)
