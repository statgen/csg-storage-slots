package CSG::Storage::Slots::Exceptions;

use Exception::Class (
  __PACKAGE__ . '::SlotExists' => {
    description => 'slot directory already exists',
  },
);

1;
