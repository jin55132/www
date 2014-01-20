#!/usr/bin/perl 
use Proc::PID::File;

print "Content-type:text/html\n\n";

my $pid = Proc::PID::File->running(name=>"feed", dir=> "/run/shm");
unless ($pid)
{ 
	print "Not already running!" 
}
else
{
	kill(2,$pid);  # you may need a different signal for your system
	
	system ('kill $(ps aux | grep \'[v]lc\' | awk \'{print $2}\')');
	system ('kill $(ps aux | grep \'[r]aspivid\' | awk \'{print $2}\')');

	print "Stop camera feeding!\n";
}
