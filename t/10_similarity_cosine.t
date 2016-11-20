#!perl
use strict;
use warnings;

use lib qw(../lib/);

use Test::More;
use Data::Dumper;

my $class = 'Set::Similarity::BV::Cosine';

use_ok($class);

my $object = new_ok($class);

#my $object = $class;

sub d3 { sprintf('%.3f',shift) }

is($object->similarity(),1,'empty params');
is($object->similarity('a',),0,'a string');
is($object->similarity('8','4'),0,'a,b strings');

is($object->similarity('0','a'),0,'0, a');
is($object->similarity(['ab'],'0'),0,'ab, 0');
is($object->similarity('0','0'),1,'both 0');


is($object->similarity('ab','ab'),1,'equal  ab');
is($object->similarity('a0','0a'),0,'a0 unequal 0a');
is($object->similarity('f','3'),0.5,'f 0.5 3');

is($object->similarity('f'x8,'3'x8),0.5,'fx8 0.5 3x8');

done_testing;
