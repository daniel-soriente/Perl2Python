#!/usr/bin/python2.7 -u
import sys
# Test for Subset3 - sys.stdin, Complex Print
# Taken from Perl Lecture notes
# http://www.cse.unsw.edu.au/~cs2041/13s2/lec/perl/perl.notes.html

for line in sys.stdin:
	sys.stdout.write("%s" % (line))
