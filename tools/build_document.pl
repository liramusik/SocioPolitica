#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

use File::Path;
use File::Spec::Functions;
use File::Copy;

use 5.010;

my $doc = shift;
chomp(my @documents = `ls Documentos/`);
die "Debe indicar el nombre código del documento. Documentos disponibles:",
    join "\n\t",  '', @documents unless $doc;
chomp($doc);

die "El documento $doc ya existe \n" if $doc ~~ @documents;

mkpath(catfile('Documentos', $doc));
mkpath(catfile('Documentos', $doc, 'src'));
mkpath(catfile('Documentos', $doc, 'build', 'chapters'));
mkpath(catfile('Documentos', $doc, 'build', 'html'));
mkpath(catfile('Documentos', $doc, 'build', 'latex'));
mkpath(catfile('Documentos', $doc, 'build', 'pdf'));


my $path_latex = catfile('Documentos', $doc, 'build', 'latex');
my $path_latex_doc = catfile($path_latex, $doc);
my $path_src = catfile('Documentos', $doc, 'src');

&copy_doc_tex;
&copy_portada_tex;
&version_tex;
&titulo;
&subtitulo;
&chapter;

sub copy_doc_tex {
    my $doc = catfile('Templates', 'doc.tex');
    copy $doc, $path_latex_doc.'.tex';
}

sub copy_portada_tex {
    my $doc = catfile('Templates', 'portada.tex');
    my $doc_dst = catfile($path_latex, 'portada.tex');
    copy $doc, $doc_dst;
}

sub version_tex {
    my $version = catfile($path_latex, 'version.tex');
    open VERSION, ">", $version;
    print VERSION "0.1";
    close VERSION;
}

sub titulo {
    say "Por favor indique el título del documento:";
    chomp(my $titulo = <STDIN>);
    my $titulo_tex = catfile($path_latex, 'titulo.tex');
    open TITULO, ">", $titulo_tex;
    print TITULO $titulo;
    close TITULO;
}

sub subtitulo {
    say "Por favor indique el subtitulo del documento:";
    chomp(my $titulo = <STDIN>);
    my $titulo_tex = catfile($path_latex, 'subtitulo.tex');
    open TITULO, ">", $titulo_tex;
    print TITULO $titulo;
    close TITULO;
}

sub chapter {
    my $chapter = catfile($path_src, 'chapter_01.pod');
    open CHAPTER, ">", $chapter;
    print CHAPTER "=head0 Capitulo Ejemplo";
    close CHAPTER;
}
