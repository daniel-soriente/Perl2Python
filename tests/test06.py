#!/usr/bin/python2.7 -u
import sys
# Test for Subset 3 - chomp, split, join, ARGV

joined = ' '.join(sys.argv[1:])
split = joined.split(' ')
for argv in sys.argv[1:]:
	argv = argv.rstrip()
	print "argv: %s" % (argv)
	print "%s" % (joined)

for l in split:
	print "%s" % (l)
