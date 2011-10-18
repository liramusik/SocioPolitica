#!/usr/bin/perl
use strict;
use warnings;
use lib ( "./lib" );
use Glosario_db;
use 5.010;

use File::Basename;
use File::Spec::Functions;

my $doc = shift;
my $acr;
my $f;

#Conexion a la base de datos
my $schema = Glosario_db->connect('dbi:SQLite:dbname=Glosario/Glosario.sqlite');
my @acronimos = $schema->resultset( 'Acronimo' )->search->all;


my @documents = `ls Documentos/`;
die "Debe indicar el nombre código del documento. Documentos disponibles:",  join "\n\t",  '', @documents unless $doc;

    foreach (@acronimos){
        my $nombre = $_->nombre;
        my $acronimo = $_->acronimo;
            $acr->{$_->acronimo} = {
                descripcion => $_->descripcion,
                nombre      => $_->nombre,
                tipo        => $_->tipo,
                url         => $_->url, 
                acronimo    => $_->acronimo
            }
                    
    }    

inlatex();

sub inlatex {
    #Crea entrada de glosario en .tex
    open (GLOSARIO, ">", "Documentos/$doc/build/latex/glosario.tex");
               
    foreach my $k ( keys %{$acr} ) {
        print GLOSARIO
        "\\newglossaryentry{$acr->{$k}->{acronimo}}{\n\t"."name=$acr->{$k}->{nombre},\n\t"."description={\n\t$acr->{$k}->{descripcion}\n\t}\n}\n";
    }

    close (GLOSARIO);
    
   }
