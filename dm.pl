#!/usr/bin/perl
  # turn on the safety features
use Proc::Daemon;
use Proc::PID::File;
  # did we get a stop command?
  if (@ARGV && $ARGV[0] eq "stop")
  {
    my $pid = Proc::PID::File->running(name => "blacklist", dir=> "/run/shm");
	print "$pid";

    unless ($pid)
     { die "Not already running!" }
    kill(2,$pid);  # you may need a different signal for your system
    print "Stop signal sent!\n";
    exit;
  }

  my $daemon = Proc::Daemon->new(child_STDOUT => '/run/shm/out', child_STDERR => '/run/shm/err');

  $daemon->Proc::Daemon::Init;
  if (Proc::PID::File->running(name => "blacklist", dir => "/run/shm"))
   { die "Already running!" }

   $| = 1;
   #select STDOUT;
print "Hello WOrld";
#system 'raspistill -w 720 -h 480 -q 85 -o a.jpg');
while(1)
{
	print("looping");
	sleep(5);
}

