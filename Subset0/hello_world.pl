#!/usr/bin/perl -w

$hello = "world";
if ($hello =~ /world/) {
	print "match $hello";
} else {
	print "NO $hello";
}
