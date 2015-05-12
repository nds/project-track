package EcapFind::Project;

# ABSTRACT: Holds the information for a project in the ecap database
# [COMPLETE]

=head1 SYNOPSIS

Fill in

=head1 SEE ALSO

=for :list

=cut

use Moose;
use Cwd;
use File::Basename;


has '_dbh'  => (
    is          => 'ro',
    isa         => 'DBI::db',
    required    => 1,
    init_arg    => 'dbh',
);

has 'id'    => (
    is          => 'ro',
    isa         => 'Str',
    required    => 1,
);

has 'title'=> (
    is          => 'ro',
    isa         => 'Str',
    required    => 1,
);


# Populate the parameters from the database
around BUILDARGS => sub {
     my $orig  = shift;
     my $class = shift;
     
     my $argref = $class->$orig(@_);
     die "Need to call with a project id" unless $argref->{id};
 
     my $sql = qq[select * from grants_register where id=? ];
     my $id_ref = $argref->{dbh}->selectrow_hashref($sql, undef, ($argref->{id}));
     if ($id_ref){
         foreach my $field(keys %$id_ref){
             $argref->{$field} = $id_ref->{$field};
         }
     };
     return $argref;
 };



__PACKAGE__->meta->make_immutable;
1;
