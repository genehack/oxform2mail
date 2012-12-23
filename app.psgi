#! /usr/bin/env perl
# PODNAME: app.psgi

use 5.016;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";

use OXform2email;
use YAML    qw/ LoadFile /;

my $config_file = "$FindBin::Bin/oxform2email.yaml";
my $config = LoadFile( $config_file ) // {}
  if( -e $config_file );

OXform2email->new( $config )->to_app;
