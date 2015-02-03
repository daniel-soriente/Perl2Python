#!/usr/bin/perl -w
# Test for Subset 3 - chomp, split, join, ARGV

$joined = join(' ', @ARGV);
@split = split(' ', $joined);
for $argv (@ARGV) {
	chomp $argv;
	print "argv: $argv\n";
	print "$joined\n";
}

for $l (@split) {
	print "$l\n";
}
