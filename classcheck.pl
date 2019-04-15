#!/usr/bin/perl -w
if ($#ARGV == -1) {
	die "Usage: perl classcheck.pl XXXX#### [-t1] [-t2] [-t3] [-c####]\n";
}
my $course = $ARGV[0];
if (!($course =~ /[A-Z]{4}[0-9]{4}/)) {
	die "Usage: perl classcheck.pl XXXX#### [-t1] [-t2] [-t3] [-c####]\n";
}
my @termFilter;
my @classFilter;
foreach my $arg (@ARGV) {
	if ($arg =~ /^-t([1-3])$/) {
		push @termFilter, $1;
	} elsif ($arg =~ /^-c([A-Z0-9]{4})$/) {
		push @classFilter, $1;
	}
}
my $faculty = substr $course, 0, 4;
my $code = substr $course, 4, 4;
my $url = "http://classutil.unsw.edu.au/".$faculty."_T";
print "Course: ".$course."\n";
for (my $term = 1; $term <= 3; $term++) {
	if ($#termFilter != -1 and !(grep( /$term/, @termFilter))) {
		next;
	}
	my $urlTerm = $url.$term.".html";
	print "=== Term ".$term." ===\n";
	open F, "wget -q -O- $urlTerm|" or die;
	@html = <F>;
	close F;
	my $found = 1;
	foreach my $line (@html) {
		if ($found) {
			my $searchString = "<a name=\"".$course."T".$term."\"><\/a>";
			if ($line =~ /$searchString/){
				$found = 0;
			}
		} else {
			if ($line =~ /<a name=\"[A-Z]{4}[0-9]{4}T[1-3]\"><\/a>/) {
				last;
			}
			if ($line =~ /([A-Z]{3}).*([A-Z0-9]{4}).*([0-9]{4}).*?([0-9]+\/[0-9]+).*?([0-9]*)%/) {
				if ($#classFilter != -1) {
					my $skip = 1;
					foreach my $class (@classFilter){
						if (($2 eq $class) or ($3 eq $class)) {
							$skip = 0;
							last;
						}
					}
					if ($skip) {
						next;
					}
				}
				print $1, "\t", $2, "\t", $3, "\t", $4, "\t", $5, "%\n";
			}
		}
	}
	if ($found) {
		print "Class does not run in Term ", $term, "\n";
	}
	
}
