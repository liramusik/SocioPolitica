package Glosario_db::Result::Acronimo;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Glosario_db::Result::Acronimo

=cut

__PACKAGE__->table("acronimos");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 acronimo

  data_type: 'varchar'
  is_nullable: 0

=head2 nombre

  data_type: 'varchar'
  is_nullable: 1

=head2 descripcion

  data_type: 'text'
  is_nullable: 0

=head2 tipo

  data_type: 'char'
  is_nullable: 0

=head2 url

  data_type: 'varchar'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "acronimo",
  { data_type => "varchar", is_nullable => 0 },
  "nombre",
  { data_type => "varchar", is_nullable => 1 },
  "descripcion",
  { data_type => "text", is_nullable => 0 },
  "tipo",
  { data_type => "char", is_nullable => 0 },
  "url",
  { data_type => "varchar", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("sqlite_autoindex_acronimos_2", ["nombre"]);
__PACKAGE__->add_unique_constraint("sqlite_autoindex_acronimos_1", ["acronimo"]);


# Created by DBIx::Class::Schema::Loader v0.07000 @ 2011-07-29 00:16:01
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Nxu52gqbcuBj6MWClqf7/g


# You can replace this text with custom content, and it will be preserved on regeneration
1;
