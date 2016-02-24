## no tidy
package CSG::Storage::Slots::Types;

use Moose::Util::TypeConstraints;

use CSG::Storage::Slots::DB;

subtype 'ValidProject',
  as 'Str',
  where {
    my $schema = CSG::Storage::Slots::DB->new();
    defined $schema->resultset('Project')->find({name => $_});
  },
  message {"Project name, $_, is not a valid project"};

subtype 'ValidSlotSize',
  as 'Str',
  where { 1; }, # TODO - not sure how i want to validate this yet
  message {"Slot size, $_, is not valid"};

subtype 'ValidSlotName',
  as 'Str',
  where {
    my $schema = CSG::Storage::Slots::DB->new();
    not defined $schema->resultset('Slot')->find({name => $_});
  },
  message {"Slot name, $_, already exists"};

no Moose::Util::TypeConstraints;

1;
