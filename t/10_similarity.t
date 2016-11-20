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


done_testing;
