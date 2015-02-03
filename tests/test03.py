#!/usr/bin/python2.7 -u
# Test for Subset2 - Operators

string1 = "Hello"
string2 = "Goodbye"

if (string2 == "Hello" or string2 >= "Goodbye"):
	print string1
elif (string1 >= "Good"):
	print "%s" % (string2)
else:
	print "World"

while (string1 != "Hello"):
	print "break"
	break
