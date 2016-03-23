package CSG::Storage::Slot;

use App::Cmd::Setup -app;

sub global_opt_spec {
  return (
    ['debug|d',   'Debug output'],
    ['verbose|v', 'Verbose output'],
    ['dry-run|n', 'Dry run; show what would be done without actaully doing anything'],
  );
}

1;
