#!perl
use strict;
use warnings;

use lib qw(../lib/ );

use Test::More;
use Test::Exception;

my $class = 'Set::Similarity::BV';

use_ok($class);

my $object = new_ok($class);



dies_ok { $object->from_integers() } ;

ok($object->new());
ok($object->new(1,2));
ok($object->new({}));
ok($object->new({a => 1}));

ok($class->new());

is($object->min(0,0),0,'0,0 -> 0');
is($object->min(0,1),0,'0,1 -> 0');
is($object->min(1,0),0,'1,0 -> 0');


done_testing;
