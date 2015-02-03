#!/usr/bin/perl -w
# Test for subset4 - variable interpolation
# Taken from lecture slides
# http://www.cse.unsw.edu.au/~cs2041/13s2/lec/perl/perl.notes.html

$pattern = "ab+";
$replace = "Yod";
$text = "abba";

$text =~ s/$pattern/$replace/;
print "$text\n";
   # converts "abba" to "Yoda"
