#!/usr/bin/env perl
use strict;
use warnings;
use POSIX;
use Term::Cap;
use 5.010;

use lib ( "./lib" );
use Glosario_db;

sub user_input;
sub ingresar_acronimo;
sub menu;

my $schema = Glosario_db->connect('dbi:SQLite:dbname=Glosario/Glosario.sqlite');

my $acronimo; 

MENU: while (1){
    menu;
    given (<STDIN>){
        when (/1/){ ingresar_acronimo() } 
        when (/2/){ mod_acronimo() }
        when (/3/){ lista_acronimos(); <STDIN> } 
        when (/4/){ ver_acronimo() } 
        when (/5|q/){ last MENU } 
        default { last MENU }
    }
    
}


sub mod_acronimo {
    lista_acronimos();
    print "Nota: Si solo presiona ENTER el valor no sera modificado\n\n";
    print "Indique el ID del acrónimo: ";
    chomp(my $id = <STDIN>);
    my $acronimo = $schema->resultset('Acronimo')->find($id);
    if ($acronimo){
        printf "Indique el acrónimo (%s): ", $acronimo->acronimo;
        my $acr = <STDIN>;
        unless ($acr ~~ /^\n/){
            chomp($acr);
            $acronimo->acronimo($acr);
            $acronimo->update();
        }

        printf "Indique el nombre (%s): ", $acronimo->nombre;
        my $nombre = <STDIN>;
        unless ($nombre ~~ /^\n/){
            chomp($nombre);
            $acronimo->nombre($nombre);
            $acronimo->update();
        }
        
        printf "Indique la descripción \n(%s)\n: ", $acronimo->descripcion;
        my $desc = <STDIN>;
        unless ($desc ~~ /^\n/){
            chomp($desc);
            $acronimo->descripcion($desc);
            $acronimo->update();
        }
        
        printf "Indique la URL (%s)\n: ", $acronimo->url;
        my $url = <STDIN>;
        unless ($url ~~ /^\n/){
            chomp($url);
            $acronimo->url($url);
            $acronimo->update();
        }

    }
}

sub ver_acronimo {
    lista_acronimos();
    print "Indique el ID del acrónimo: ";
    chomp(my $id = <STDIN>);
    my $acronimo = $schema->resultset('Acronimo')->find($id);

    if ($acronimo){
        system "clear";
        printf "ID: %d\n", $acronimo->id;
        printf "Acrónimo: %s\n", $acronimo->acronimo;
        printf "Nombre: %s\n", $acronimo->nombre;
        printf "Descripción: \n%s\n\n", $acronimo->descripcion;
        printf "URL: \n%s\n\n", $acronimo->url;

        print "\n\nPresione Enter para continuar";
        <STDIN>;
    }

}

sub lista_acronimos {
    my @acronimos = $schema->resultset('Acronimo')->search({})->all;
    
    system "clear";
    printf "%-3s | %-20s | %-50s |\n", 'ID', 'Acrónimo', 'Nombre';
    print "-" x 80;
    print "\n";
    foreach (@acronimos){
        printf "%-3d) %-20s | %-50s |\n", $_->id, $_->acronimo, $_->nombre; 
    }

}

sub ingresar_acronimo {
    user_input();
    print "¿ Desea crear el acrónimo (s/n) ? ";
    chomp(my $resp = <STDIN>);
    
    if ($resp eq 's'){
        my $a = $schema->resultset( 'Acronimo' )->create({
                acronimo => $acronimo->{'acronimo'}, 
                nombre => $acronimo->{'nombre'}, 
                descripcion => $acronimo->{'descripcion'}, 
                url => $acronimo->{'url'}, 
                tipo => 'g', 
            });
    
        printf "Acrónimo %s creado satisfactoriamente bajo el id: %d\n", $a->acronimo, $a->id;
    
    } else {
        user_input;
    }
}



sub user_input {

    print "\n\n";
    print "Indique el acrónimo: ";
    chomp($acronimo->{'acronimo'} = <STDIN>);

    printf "Indique el nombre para el acrónimo (%s): ", $acronimo->{'acronimo'};
    chomp($acronimo->{'nombre'} = <STDIN>);

    printf "Indique la descripción para el acrónimo (%s): ", $acronimo->{'acronimo'};
    chomp($acronimo->{'descripcion'} = <STDIN>);

    printf "Indique la URL para el acrónimo (%s): ", $acronimo->{'acronimo'};
    chomp($acronimo->{'url'} = <STDIN>);

}

sub menu {
    
    my $menu = "
    1) Ingresar un acrónimo a la base de datos. 
    2) Modificar un acrónimo. 
    3) Listar los acrónimos. 
    4) Ver un acrónimo. 
    5) Salir (q)

    Indique la opción: ";
    system "clear";
    printf "%s", $menu;

}
