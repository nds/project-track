#!/usr/bin/env perl
use strict;
use warnings;
use DBI;
use EcapFind::Project;

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
#	print "$key $value \n";
}

my $dbh = DBI->connect("DBI:mysql:host=$db{\"host\"}:port=$db{\"port\"};database=$db{\"db\"}", $db{"user"} , $db{"password"}, {'RaiseError' => 1, 'PrintError'=>0});
my @ids = ('G0317-145-MRC');

my $project = EcapFind::Project->new({dbh => $dbh, id => $ids[0]});
is($project->id, 'G0317-145-MRC', "Project id OK");
is($project->title, 'The interactions between Clostridium difficile, intestinal microbiota and the host response in hospitalised patients', 'Project name OK');


$dbh->disconnect();
done_testing();
