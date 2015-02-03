#!/usr/bin/perl -w
# Demo for Subset3 - .., ++, --

for $i (0..2) {
	while ($i < 3) {
		$i--;
		print "Minus: $i\n";
		$i++;
		$i++;
	}	
}
