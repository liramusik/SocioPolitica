#!perl

use strict;
use warnings;
use lib 'lib/';

use File::Basename;
use File::Spec::Functions;
use Pod::PseudoPod::Checker;

my $doc = shift;
my @documents = `ls Documentos/`;
die "Debe indicar el nombre código del documento. Documentos disponibles:",  join "\n\t",  '', @documents unless $doc;

chomp(my @files = `ls Documentos/$doc/src/*.pod`); 

for my $file (@files)
{
    print "$file :";
    die "Cannot read '$file': $!\n" unless -e $file;
    my $checker = Pod::PseudoPod::Checker->new();

    $checker->parse_file($file);
}
