#!/usr/bin/python2.7 -u
import sys
# Test for Subset2 - Statements

hELLO = 109

if (hELLO == 109):
	print "Found"
else:
	if (hELLO < 110):
		print "It's Big"
	elif ((((1)))):
		print "That was alot of brackets"
	else:
		print "It's Smaller"
	print "Not Found"

int = 5
for i in xrange(0, int+1):
	sys.stdout.write("%d" % (i))
	if (i == 2):
		for k in xrange(0, int+1):
			print "Nested For Loop"

sys.stdout.write("While loop: ")
while (int < 10):
	while (int < 10):
		while (int < 10):
			sys.stdout.write("%d" % (int))
			int += 2

print ""
