#!/usr/bin/perl -w
# Demo for Subset2 - Statements

$hELLO = 109;
if ($hELLO == 109) {
	print "Found\n";
} else {
	print "Not Found\n";
}

		$hELLO = $hELLO + 10;
if ($hELLO == 109) {
	print "Found\n";
		} else {
print "Not Found\n";
				}

if ($hELLO == 109) {
						print "Found\n";
} else {
		if ($hELLO < 110) {
			print "It's Big\n";
}elsif ((((1)))){
		print "That was alot of brackets\n";
								} else {
	print "It's Smaller\n";
}
	print "Not Found\n";
					}

					
				$int = 5;
for $i (0..$int) {
		print "$i";
	if ($i == 2) {
						for $k (0..$int) {
print "Nested For Loop $k\n";
}
			}	
}

while ($int < 10) {
			print $int;
														$int = $int + 1;
}

print "\n";
