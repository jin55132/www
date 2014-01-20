#!/usr/bin/env perl
my $base_dir = "/sys/bus/w1/devices";
my $device_folder = <$base_dir/28*>;
my $device_file = $device_folder . '/w1_slave';

while (1) {
	open DH, '<', $device_file or die "failed to open thermo device :$!";
	chomp(my $readline = <DH>); 
	next unless $readline =~ /YES\z/;
	chomp($readline = <DH>);
	my $temp = substr($readline, index($readline, "t=") + 2);
	print &temp_format($temp) . ','  . (&temp_format($temp) * (9/5) + 32) . "\n";
	close DH;
}

sub temp_format {
	my $temp = shift @_;
	$temp =~ s/^(-?\d+)(\d\d\d)/$1.$2/;
	$temp;
}
