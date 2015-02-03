#!/usr/bin/perl -w

@perl = <>;

@import = ();
@python = ();
for $index (0..@perl-1) {
	$line = $perl[$index];
	# Get rid of white spaces at the beginning and end of line
	if ($line =~ s/^\s*(.*)\s*$/$1/g) {}
	
        if ($line =~ /^#!/ && $line =~ /\bperl\b/) {
		push (@import, "#!/usr/bin/python2.7 -u");
	} else {
		if ($line !~ /^#/ || $line =~ /^\s*$/) {
			$line = remove_semicolon ($line);
			$line = change_argv ($line);
			$line = change_match ($line);
			$line = change_substitution ($line);
			$line = change_concatenation ($line);
			$line = change_print ($line, @perl);
			$line = change_printf ($line);
			$line = change_variable ($line);
			$line = change_operators ($line);
			$line = change_if ($line);
			$line = change_while ($line);
			$line = change_for ($line);
			$line = change_last ($line);
			$line = change_next ($line);
			$line = change_plusplus ($line);
			$line = change_minusminus ($line);
			$line = change_chomp ($line);
			$line = change_split ($line);
			$line = change_join ($line);
			$line = change_input ($line, $index, @perl);
			$line = change_array ($line);
		}
		
		push (@python, $line);
	}
}

$tabs = 0;

my %count = ();
@import = grep { !$count{$_}++ } @import;
foreach my $imp (@import) {
	print "$imp\n";
}

foreach my $line (@python) {
	if ($line =~ /^\s*}\s*$/ || $line =~ /^\s*\belse\b:\s*$/ || $line =~ /^\s*\belif\b\s*/) {
		$tabs--;
	}
	
	if ($line !~ /^\s*}\s*$/) {
		foreach (1..$tabs) {
			$line = "\t".$line;
		}
		print "$line\n";
	}
	
	if ($line =~ /^\s*\bif\b\s*.*:\s*$/ || $line =~ /^\s*\bwhile\b\s*.*:\s*$/ || $line =~ /^\s*\bfor\b\s*.*:\s*$/ || 
	    $line =~ /^\s*\belse\b:\s*$/ || $line =~ /^\s*\belif\b.*\s*$/) {
		$tabs++;
	}
}

sub remove_semicolon {
	my ($line) = @_;
	if ($line =~ s/;(\s*$)/$1/g) {}
	return $line;
}

sub change_variable {
	my ($line) = @_;
	@variables = ();
	
	# Variable Interpolation
	if ($line =~ /"[^"]*\s*\$[\"^"]*\s*[^"]*"/) {

		while ($line =~ /"[^\$]*\$([^\s"%\$]*)\s*.*"/ && $line !~ /\\\$/) {
			push (@variables, $1);
			$variable = $1;

			for $l (@perl) {
				if ($l =~ /\$$variable/) {
					if ($l =~ /=\s*\d+/) {
						if ($line =~ s/\$$variable/\%d/) {}
					} else {
						if ($line =~ s/\$$variable/\%s/) {}
					}
					last;
				}
			}
		}
	}

	if ($line =~ /\$/ && $line !~ /\\\$/) {
		if ($line =~ s/\$//g) {}
	}
	
	if (@variables) {
		$var = " % (";
		for $index (0..@variables-1) {
			if ($index == @variables-1) {
				$var .= "$variables[$index])";
			} else {                                              
				$var .= "$variables[$index], ";
			}
		}
	}
	
	# Initialisation of Variable
	if ($line =~ s/\(\)/None/g) {}
	
	return $line;
}

sub change_print {
	my ($line, @array) = @_;
	if ($line =~ /^\s*\bprint\b\s*(.*)\s*$/) {
		
		my $print = $1;
		my $newline = 0;
		my @variables = ();
		if ($print =~ /\\n/ && $print !~ /\\\\n/) {
			if ($print =~ s/\\n//g) {}
			$newline = 1;
		}
		if ($print =~ s/, ""//g) {}

		# If print lists things to be printed
		# Combine them all into one in one quotation marks
		# And replace variables with %s and add to array
		# E.g. "hello", $world = "hello%s" % (world)
		# Variable Interpolation
		while ($print =~ /\s*,\s*["\$]/) {
			if ($print =~ /^\$([^\s",]*)\s*,\s*/) {
				push (@variables, $1);
				
				if ($print =~ s/\$$1\s*,\s*/"\%s", /) {}
			} elsif ($print =~ /\s*,\s*\$([^\s",]*)/) {
				push (@variables, $1);

				if ($print =~ s/, \$$1/, "\%s"/) {}
			} elsif ($print =~ s/"\s*,\s*"//) {}
		}
		
		# We want to print a variable thats in quotation marks
		if ($print =~ /".*\s*\$.*\s*.*"/) {
			# Variable Interpolation
			while ($print =~ /"[^\$]*\$([^\s"%\$]*)\s*.*"/ && $print !~ /\\\$/) {
				push (@variables, $1);
				$variable = $1;
				for $l (@array) {
					if ($l =~ /\$$variable/) {
						if ($l =~ /=\s*\d+/) {
							if ($print =~ s/\$$variable/\%d/) {}
						} else {
							if ($print =~ s/\$$variable/\%s/) {}
						}
						last;
					}
				}
			}
		} else {
			# We want to print a variable outside of quotation marks
			if ($print =~ s/\$([^\s]*)/$1/g) {
				if ($newline == 0) {
					push(@variables, $1);
					$variable = $1;
					for $l (@array) {
						if ($l =~ /\$$variable/) {
							if ($l =~ /=\s*\d+/) {
								if ($print =~ s/$variable/\%d/) {}
							} else {
								if ($print =~ s/$variable/\%s/) {}
							}
							last;
						}
					}
				}
			}
			
		}

		# Variable Interpolation
		if (@variables) {
			# Put things we want to print in quotation marks
			if ($print !~ /".*"/) {
				if ($print =~ s/$print/"$print"/) {}
			}
			$var = " % (";
			for $index (0..@variables-1) {
				if ($index == @variables-1) {
					$var .= "$variables[$index])";
				} else {                                              
					$var .= "$variables[$index], ";
				}
			}
			
			# Joining 2 strings
			if ($print =~ /(".*")\+(".*")/ || $print =~ /(".*")\+(\$.*)/ || $print =~ /(\$.*)\+(".*")/ || $print =~ /(\$.*)\+(\$.*)/) {
				$one = $1;
				$two = $2;
				if ($one =~ /\%[ds]/ && $two =~ /\%[ds]/) {
					if ($print =~ s/$one\+$two/$one $var + $two $var/g) {}
				} elsif ($one =~ /\%[ds]/) {
					if ($print =~ s/$one\+$two/$one $var + $two/g) {}
				} elsif ($two =~ /\%[ds]/) {
					if ($print =~ s/$one\+$two/$one + $two $var/g) {}
				}
			} else {
				$print .= $var;
			}
		}

		# if we have removed a newline character, we want to print it with newline
		# otherwise no we don't want a newline character
		if ($newline == 1) {
			$line = "print $print";
		} else {
			push (@import, "import sys");
			$line = "sys.stdout.write($print)"
		}
	}
	
	return $line;
}

sub change_operators {
	my ($line) = @_;
	
	#logical operators
	if ($line =~ s/\(\s*!\s*/\(not /g) {}
	if ($line =~ s/\s+&&\s+/ and /g) {}
	if ($line =~ s/\s+\|\|\s+/ or /g) {}
	
	#comparison operators
	if ($line =~ s/\s+lt\s+/ < /g) {}
	if ($line =~ s/\s+gt\s+/ > /g) {}
	if ($line =~ s/\s+le\s+/ <= /g) {}
	if ($line =~ s/\s+ge\s+/ >= /g) {}
	if ($line =~ s/\s+eq\s+/ == /g) {}
	if ($line =~ s/\s+ne\s+/ != /g) {}
	return $line;
}

sub change_if {
	my ($line) = @_;
	if ($line =~ /\s*\bif\b\s*[\(]+.*[\)]+\s*{/ || $line =~ /\s*\belsif\b\s*[\(]+.*[\)]+\s*{/ || $line =~ /^\s*}\s*\belse\b\s*{\s*$/) {
		if ($line =~ s/\s*{\s*$/:/) {}
		if ($line =~ s/\belsif\b/elif/g) {}
		if ($line =~ s/^\s*}\s*//g) {}
	}

	return $line;
}

sub change_while {
	my ($line) = @_;
	if ($line =~ /\s*\bwhile\b\s*[\(]+.*[\)]+\s*{/) {
		if ($line =~ s/\s*{\s*$/:/) {}
	}
	
	return $line;
}

sub change_for {
	my ($line) = @_;
	if ($line =~ /^\s*\bfor\b\s*(.*)\s*{/ || $line =~ /^\s*\bforeach\b\s*(.*)\s*{/) {
		# Loop for a given range (i.e numbers or numerical variables)
		if ($line =~ /(\w+) \((\w+)..(\w+)\)/) {
			$line = "for $1 in xrange($2, $3+1):";
		}

		# Loop for a given variable (i.e lists/arrays)
		if ($line =~ /(\w+) \((.*)\)/) {
			$line = "for $1 in $2:";
		}
	}

	return $line;
}

sub change_last {
	my ($line) = @_;
	if ($line =~ s/^\s*\blast\b\s*$/break/g) {}

	return $line;
}

sub change_next {
	my ($line) = @_;
	if ($line =~ s/^\s*\bnext\b\s*$/continue/g) {}
	 
	return $line;
}

sub change_plusplus {
	my ($line) = @_;
	if ($line =~ s/\+\+/ += 1/g) {}
	return $line;
}

sub change_minusminus {
	my ($line) = @_;
	if ($line =~ s/--/ -= 1/g) {}
	return $line;
}

sub change_chomp {
	my ($line) = @_;
	if ($line =~ s/^\s*chomp\s*([^;]*)\s*/$1 = $1.rstrip\(\)/g) {}
	
	return $line;
}

sub change_split {
	my ($line) = @_;
	if ($line =~ s/split\s*\((.*),\s*(.*)\)/$2.split($1)/) {}
	 
	return $line;
}

sub change_join {
	my ($line) = @_;
	if ($line =~ s/join\s*\((.*),\s*(.*)\)/$1.join($2)/) {}
	
	return $line;
}

sub change_argv {
	my ($line) = @_;
	if ($line =~ /ARGV/) {
		push (@import, "import sys");
		
		if ($line =~ s/\@ARGV/sys.argv[1:]/g) {}
		if ($line =~ s/\$ARGV\[(.*)\]/sys.argv[$1+1]/g) {}
		if ($line =~ s/\$#ARGV/len(sys.argv) - 1/g) {}
	}

	return $line;
}

sub change_input {
	my ($line, $index, @array) = @_;

	if ($line =~ /\s*.*<\w*>.*\s*/) {
		if ($line =~ /<>/) {
			push (@import, "import fileinput");
			if ($line =~ s/<>/fileinput.input()/g) {}
			if ($line =~ /\bwhile\b\s*\(([^\s]*)\s*=\s*([^\s]*)\)\s*/) {
				$line = "for $1 in $2:";
			}
		}
	
		if ($line =~ /<STDIN>/) {
			push (@import, "import sys");
			if ($line =~ /\bfor\b/ || $line =~ /\bwhile\b/ || $line =~ /\bif\b/) {
				if ($line =~ s/<STDIN>/sys.stdin/g) {}
				if ($line =~ /\bwhile\b\s*\(([^\s]*)\s*=\s*([^\s]*)\)\s*/) {
					$line = "for $1 in $2:";
				}
			} elsif ($line =~/@.*\s*=\s*/) {
				if ($line =~ s/<STDIN>/sys.stdin.readlines\(\)/g) {}	
			} else {
				if ($line =~ s/<STDIN>/sys.stdin.readline\(\)/g) {}
				$variable = ();
				if ($line =~ /([^\s]*)\s*=/) {
					$variable = $1;
				}
				for $i ($index..@array-1) {
					# If the line contains the variable
					# And it has numerical arithmetic or numbers
					# Then we want to read in a float
					if ($array[$i] =~ /$variable/) {
						if ($array[$i] =~ /[\+\-\*\/\d]/) {
							if ($line =~ s/sys.stdin.readline\(\)/float(sys.stdin.readline\(\))/){
								last;
							}
						}
					}
				}
			}
		}
	}
	return $line;
}

sub change_concatenation {
	my ($line) = @_;

	# Joining 2 strings
	if ($line =~ s/(".*")\.(".*")/$1+$2/g) {}
	# Joining a string with variable
	if ($line =~ s/(".*")\.(\$.*)/$1+$2/g) {}
	# Joining a variable with a string
	if ($line =~ s/(\$.*)\.(".*")/$1+$2/g) {}
	# Joining 2 variables
	if ($line =~ s/(\$.*)\.(\$.*)/$1+$2/g) {}
	if ($line =~ s/\.=/\+=/g) {}

	return $line;
}

sub change_printf {
	my ($line) = @_;
	if ($line =~ /\s*\bprintf\b\s*(.*)\s*$/) {
		my $print = $1;
		my $newline = 0;
		if ($print =~ /\\n/ && $print !~ /\\\\n/) {
			if ($print =~ s/\\n//g) {}
			$newline = 1;
		}
		if ($print =~ s/, ""//g) {}
		
		if ($print =~ s/\s*, (.*)/ % \($1\)/) {
			if ($print =~ s/(% \(.*)\$(.*)/$1$2/) {}
		}
		# if we have removed a newline character, we want to print it with newline
		# otherwise no we don't want a newline character
		if ($newline == 1) {
			$line = "print $print";
		} else {
			push (@import, "import sys");
			$line = "sys.stdout.write($print)";
		}
	}
	
	return $line;
}

sub change_match {
	my ($line) = @_;
	if ($line =~ /\s*=~\s*\/.*\//) {
		if ($line =~ s/([^\s\(]*)\s*=~\s*\/([^\/]*)\//re.match($1, '$2')/g) {
			push (@import, "import re");
		}
	}

	return "$line";
}

sub change_substitution {
	my ($line) = @_;

	if ($line =~ /\s*=~\s*s\/.*\/.*\//) {
		
		
			if ($line =~ s/([^\s\(]*)\s*=~\s*s\/(.*)\/(.*)\//$1 = re.sub(r'$2', '$3', $1)/) {
				push (@import, "import re");
			}
		
	}

	return "$line";
}

sub change_array {
	my ($line) = @_;
	
	if ($line =~ /\@/ && $line !~ /\\\@/) {
		if ($line =~ s/\@//g) {}
	}
	
	return $line;
}
