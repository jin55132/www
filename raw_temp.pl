#!/usr/bin/perl 
use warnings;
use strict;
my $base_dir = "/sys/bus/w1/devices";
my $device_folder = <$base_dir/28*>;
my $device_file = $device_folder . '/w1_slave';

while (1) {
	open DH, '<', $device_file or die "failed to open thermo device :$!";
	chomp(my $readline = <DH>); # read the 1st line
	next unless $readline =~ /YES\z/;
	chomp($readline = <DH>); #read the 2nd line
	my $temp = substr($readline, index($readline, "t=") + 2);
	print "Celsius: ".  &temp_format($temp);	
	print "\n";
	print "Fahrenheit: ". (&temp_format($temp) * (9/5) + 32);
	print "\n";
	close DH;
}

sub temp_format {
	my $temp = shift @_;
	$temp =~ s/^(-?\d+)(\d\d\d)/$1.$2/;
	$temp;
}
