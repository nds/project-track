#!/usr/bin/env perl
use strict;
use warnings;
use Cwd;
use Cwd 'abs_path';
use File::Path qw(make_path remove_tree);
use DBI;

BEGIN { unshift( @INC, './lib' ) }

BEGIN {
    use Test::Most;
    use Test::File::Contents;
    use_ok('EcapFind::Project');
}

# Read config file and connect to database
my $config_file = "EcapConfig";
open my $fh, '<', $config_file or die $!;
my @lines = <$fh>;
chomp @lines;
my %db;

for my $l (@lines){
	my($key, $value) = split(":", $l);
	$db{$key} = $value;
	print "$key $value \n";
}

my $dbh = DBI->connect("DBI:mysql:host=$db{\"host\"}:port=$db{\"port\"};database=$db{\"db\"}", $db{"user"} , $db{"password"}, {'RaiseError' => 1, 'PrintError'=>0});


done_testing();