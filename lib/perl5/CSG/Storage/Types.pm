package CSG::Storage::Types;

use Moose::Util::TypeConstraints;

subtype 'ValidPrefixPath',
  as 'Str',
  where { -e $_ },
  message { "Prefix path, $_, does not exist" };

1;
