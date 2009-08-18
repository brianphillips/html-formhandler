package HTML::FormHandler::State;

use Moose;

has 'name' => ( isa => 'Str', is => 'rw', required => 1 );

# do we need 'accessor' ?
has 'parent' => ( is =>'rw' );

has 'input' => (
   is        => 'rw',
   clearer   => 'clear_input',
   predicate => 'has_input',
);
   
has 'value' => (
   is        => 'rw',
   clearer   => 'clear_value',
   predicate => 'has_value',
);

has 'errors'     => (
   metaclass  => 'Collection::Array',
   isa        => 'ArrayRef[Str]',
   is         => 'rw',
   auto_deref => 1,
   default    => sub { [] },
   provides   => {
      'push'  => 'push_errors',
      'count' => 'num_errors',
      'empty' => 'has_errors',
      'clear' => 'clear_errors',
   }
);

has 'children'     => (
   metaclass  => 'Collection::Array',
   isa        => 'ArrayRef[HTML::FormHandler::State]',
   is         => 'rw',
   auto_deref => 1,
   default    => sub { [] },
   provides   => {
      'push'  => 'add_child',
      'count' => 'num_children',
      'empty' => 'has_children',
      'clear' => 'clear_children',
   }
);
sub validated { !shift->has_errors }

has 'init_value'       => ( is  => 'rw',   clearer   => 'clear_init_value' );

1;