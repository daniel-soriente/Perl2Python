#!/usr/bin/perl -w
# Demo for Subset3 - <STDIN>, Complex Print
# Taken from Perl Lecture notes
# http://www.cse.unsw.edu.au/~cs2041/13s2/lec/perl/perl.notes.html
# and modified
$hello = "boo";
$world = "hoo";

while ($line = <STDIN>) {
    print $line, "$hello", " ", "$world", " Now Again", "helloworld", $hello, $world, $hello, " ", $world;
}
print "\n";
