#!/usr/bin/python2.7 -u
import re
import sys

hello = "world"
if (re.match(hello, 'world')):
	sys.stdout.write("match %s" % (hello))
else:
	sys.stdout.write("NO %s" % (hello))
