#!/usr/bin/python2.7 -u
import sys
# Test for Subset 3 - chomp, split, join, ARGV

string = sys.argv[0+1]
string = string.rstrip()

sys.stdout.write("%s" % (string))
print ""

array = string.split(' ')
for a in array:
	sys.stdout.write("%s" % (a))
print ""

joined = ''.join(array)
print "%s" % (joined)
