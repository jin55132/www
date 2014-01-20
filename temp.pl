#!/usr/bin/perl 
use CGI qw(:standard);
use 5.010;

my $base_dir = "/sys/bus/w1/devices";
my $device_folder = <$base_dir/28*>;
my $device_file = $device_folder . '/w1_slave';
open DH, '<', $device_file or die "failed to open thermo device :$!";

print header (-charset=> 'UTF-8');
print start_html("온도 출력");

chomp(my $readline = <DH>);
if (/YES\Z/) {
	say "no temperature sensored";
} else {
	chomp(my $readline = <DH>);
	my $temp = substr($readline, index($readline, "t=") + 2);
	print "Celsius: ".  &temp_format($temp);	
	print "\n<BR>\n";
	print "Fahrenheit: ". &celsiusToFahrenheit( &temp_format($temp));
}
print end_html;
close DH;

sub temp_format {
	my $temp = shift @_;
	$temp =~ s/^(-?\d+)(\d\d\d)/$1.$2/;
	$temp;
}

sub celsiusToFahrenheit{
	return @_[0] * (9/5) + 32;
}
