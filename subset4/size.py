#!/usr/bin/python2.7 -u
import sys
print "Enter a number: ";
a = sys.stdin.readline();
if a < 0:
	print "negative"
elif a == 0:
	print "zero"
elif a < 10:
	print "small"
else:
	print "large"
