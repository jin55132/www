#!/usr/bin/perl
use Proc::PID::File;
use Proc::Daemon;

print "Content-type:text/html\n\n";

if (Proc::PID::File->running(name => "feed", dir => "/run/shm"))
{ 
	print "Already running!";
}else {

	Proc::Daemon->Init;
	
	unless (Proc::PID::File->running(name => "feed", dir => "/run/shm"))
	{
		print "Start camera feeding daemon";
		system "raspivid -o - -t 99999999 -w 720 -h 480 -fps 24 | cvlc -vvv stream:///dev/stdin --sout '#standard{access=http,mux=ts,dst=:5001}' :demux=h264 > /dev/null 2>&1";
#		while(1)
#		{
#			sleep(1);
#		}
	}

}
