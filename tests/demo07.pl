#!/usr/bin/perl -w
# Demo for Subset4 - <>, ., .=

$string = "";
for $line (<>) {
	chomp $line;
	$line .= " hello there\n";
	print "$line";
	chomp $line;
	$string = $line."boo";
	print "STRING: $string"."hello\n";
}
