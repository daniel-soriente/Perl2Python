#!/usr/bin/python2.7 -u
# Demo for Subset3 - .., ++, --

for i in xrange(0, 2+1):
	while (i < 3):
		i -= 1
		print "Minus: %s" % (i)
		i += 1
		i += 1
