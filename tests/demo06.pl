#!/usr/bin/perl -w
# Test for Subset 3 - chomp, split, join, ARGV

$string = $ARGV[0];
chomp $string;

print $string;
print "\n";

@array = split(' ', $string);
for $a (@array) {
	print "$a";
}
print "\n";

$joined = join('', @array);
print "$joined\n";
