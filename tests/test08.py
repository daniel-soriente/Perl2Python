#!/usr/bin/python2.7 -u
import re
# Test for subset4 - variable interpolation
# Taken from lecture slides
# http://www.cse.unsw.edu.au/~cs2041/13s2/lec/perl/perl.notes.html

pattern = "ab+"
replace = "Yod"
text = "abba"

text = re.sub(r'ab+', 'Yod', text)
print "%s" % (text)
# converts "abba" to "Yoda"
