#!/usr/bin/perl -w
# Test for Subset4 - <>, ., .=

$string = "";
while ($line = <>) {
	chomp $line;
	$string .= $line;
	print $line;
}

print "$string\n";
