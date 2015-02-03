#!/usr/bin/perl -w
# Test for subset4 - printf, regexes
# Taken from devowel.pl examples in subset4

while ($line = <>) {
    chomp $line;
    $line =~ s/[aeiou]//;
    print "$line\n";
}

printf("%.3d", 7);
printf("%.2f", 3.66666);
printf("%.3s", 'foobar');
