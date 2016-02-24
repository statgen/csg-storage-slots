use utf8;
package CSG::Storage::Slots::DB::Schema::Result::Slot;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CSG::Storage::Slots::DB::Schema::Result::Slot

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::CSG::CreatedAt>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "CSG::CreatedAt");

=head1 TABLE: C<slots>

=cut

__PACKAGE__->table("slots");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 filesystem_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 alloc_size

  data_type: 'varchar'
  is_nullable: 0
  size: 45

=head2 current_size

  data_type: 'varchar'
  is_nullable: 0
  size: 45

=head2 created_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=head2 modified_at

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "filesystem_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "alloc_size",
  { data_type => "varchar", is_nullable => 0, size => 45 },
  "current_size",
  { data_type => "varchar", is_nullable => 0, size => 45 },
  "created_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  "modified_at",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<index3>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("index3", ["name"]);

=head1 RELATIONS

=head2 filesystem

Type: belongs_to

Related object: L<CSG::Storage::Slots::DB::Schema::Result::Filesystem>

=cut

__PACKAGE__->belongs_to(
  "filesystem",
  "CSG::Storage::Slots::DB::Schema::Result::Filesystem",
  { id => "filesystem_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2016-02-24 13:46:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:miNyuE5GZCfm0LJ/fmJwAw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
