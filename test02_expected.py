"Found"
"Not Found"
"Found"
"Not Found"
"Found"
"It's Big"
"That was alot of brackets"
"It's Smaller"
"Not Found"
"%d"	 % (i)
%d % (int)
""
#!/usr/bin/python2.7 -u
import sys
# Test for Subset3
# Logical Operators
# Statement, OPerators, Break/Continue
# Statements with indentation stuffed up

hELLO = 109
if (hELLO == 109):
	print "Found"
else:
	print "Not Found"

hELLO = hELLO + 10
if (hELLO == 109):
	print "Found"
else:
	print "Not Found"

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
	sys.stdout.write("%d"	 % (i))

while (int < 10):
	sys.stdout.write(%d % (int))
	int = int + 1

print ""
