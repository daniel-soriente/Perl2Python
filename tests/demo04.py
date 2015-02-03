#!/usr/bin/python2.7 -u
import sys
# Demo for Subset3 - sys.stdin, Complex Print
# Taken from Perl Lecture notes
# http://www.cse.unsw.edu.au/~cs2041/13s2/lec/perl/perl.notes.html
# and modified
hello = "boo"
world = "hoo"

for line in sys.stdin:
	sys.stdout.write("%s%s %s Now Againhelloworld%s%s%s %s" % (line, hello, world, hello, world, hello, world))
print ""
