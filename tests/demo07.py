#!/usr/bin/python2.7 -u
import fileinput
import sys
# Demo for Subset4 - <>, ., .=

string = ""
for line in fileinput.input():
	line = line.rstrip()
	line += " hello there\n"
	sys.stdout.write("%s" % (line))
	line = line.rstrip()
	string = line+"boo"
	print "STRING: %s"  % (string) + "hello"
