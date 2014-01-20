#!/usr/bin/perl
use 5.010;
use strict;
use warnings;

use Proc::Daemon;
use Proc::PID::File;

MAIN:
{

    # If already running, then exit
    if (Proc::PID::File->running()) {
       die "Already running"; 
    }

}
