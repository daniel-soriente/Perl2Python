#!/usr/bin/python2.7 -u
import fileinput
import re
import sys
# Test for subset4 - printf, regexes
# Taken from devowel.pl examples in subset4

for line in fileinput.input():
	line = line.rstrip()
	line = re.sub(r'[aeiou]', '', line)
	print "%s" % (line)

sys.stdout.write(("%.3d" % (7)))
sys.stdout.write(("%.2f" % (3.66666)))
sys.stdout.write(("%.3s" % ('foobar')))
