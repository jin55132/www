#!/usr/bin/perl 
use Proc::PID::File;

if (Proc::PID::File->running(name=>"feed", dir => "/run/shm"))
{
	print "Content-type:text/html\n\n";
	print "Camera is busy\n";
} else {
	select (STDOUT); $| = 1;
	print "Content-type: image/png\n\n";
	open (IMAGE, 'raspistill -w 720 -h 480 -q 85 -o -  |');
	print <IMAGE>;
	close IMAGE;
}
