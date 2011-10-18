#!perl

use strict;
use warnings;
use lib 'lib/';
use utf8;

use File::Basename;
use Pod::PseudoPod::LaTeX;
use File::Spec::Functions qw( catfile catdir splitpath );

sub get_latex_list;
sub create_chapter_tex;

my $doc = shift;
my @documents = `ls Documentos/`;

die "Debe indicar el nombre código del documento. Documentos disponibles:",  join "\n\t",  '', @documents unless $doc;

chomp(my @files = `ls Documentos/$doc/build/chapters/chapter_0*.pod`); 

for my $file (@files)
{
    die "Cannot read '$file': $!\n" unless -e $file;
    my $outfile   = catfile(
        'Documentos',"$doc", 'build', 'latex', 
        (fileparse( $file, qr/\.pod$/ ))[0] . '.tex'
    );
    open( my $fh, '>', $outfile ) or die "Can't write to '$outfile': $!\n";

    my $parser    = Pod::PseudoPod::LaTeX->new();
    $parser->output_fh( $fh );

    warn "$file -> $outfile\n";

    $parser->parse_file( $file );
}

create_chapter_tex;

sub create_chapter_tex {
    my $chapter = catfile( 'Documentos', $doc,'build', 'latex', 'chapters.tex' );
    open CHAPTER, ">", $chapter;
    my @chapters = map {'\input{'.basename $_.'}'} get_latex_list;
    print CHAPTER join "\n", @chapters;
    close CHAPTER;
}

sub get_latex_list {
    my $glob_path = catfile( 'Documentos', $doc,'build', 'latex', 'chapter_??.tex' );
    return glob( $glob_path );
}
