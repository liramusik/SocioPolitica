#!/usr/bin/env perl
use strict;
use warnings;
use 5.010;

chomp(@ARGV = `ls build/chapters/*.pod`);

while (<>){
    chomp;
    my $linea = $_;
    if (/^=head/){
        given ($linea){
            when (/=head3/) {
                s/=head3 //;
                s/^/\t\t\t * /;
                say;
            }
            when (/=head2/) {
                s/=head2 //;
                s/^/\t\t * /;
                say;
            }
            when (/=head1/) {
                s/=head1 //;
                s/^/\t * /;
                say;
            }
            when (/=head0/) {
                s/=head0 //;
                s/^/ * /;
                say;
            }
        }
    }
}
