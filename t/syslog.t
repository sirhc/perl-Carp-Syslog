#!perl

use strict;
use Test::More;

use lib 't/lib';
use Mock::Syslog;

use Carp::Syslog;

warn "warn1\n";
warn "warn2\n";

{
    no Carp::Syslog;
    warn "warn3\n";
}

eval {
    die "die1\n";
};

eval {
    # Only strings are logged.
    die \my $ref;
};

is_deeply \@Mock::Syslog::WARN, [ qw( warn1 warn2 ) ];
is_deeply \@Mock::Syslog::DIE,  [ qw( die1 ) ];

done_testing;
