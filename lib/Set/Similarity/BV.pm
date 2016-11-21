package Set::Similarity::BV;

use strict;
use warnings;

our $VERSION = '0.04';

use Carp 'croak';

sub new {
  my $class = shift;

  # uncoverable condition false
  bless @_ ? @_ > 1 ? {@_} : {%{$_[0]}} : {}, ref $class || $class;
}

sub similarity {
  my ($self, $hex1, $hex2) = @_;

  return 1 if (!($hex1 || $hex2));    # both zero
  return 0 unless ($hex1 && $hex2);   # one is zero

  #return 1 if (!(hex($hex1) || hex($hex2)));    # both zero
  #return 0 unless (hex($hex1) && hex($hex2) ); # one is zero

  no warnings 'portable'; # for 0xffffffffffffffff

  return $self->from_integers(
    hex($hex1),
    hex($hex2),
  );
}


sub from_integers { croak 'Method "from_integers" not implemented in subclass' }

sub intersection {
  my ($self,$v1,$v2) = @_;

  return $self->bits($v1 & $v2);
}

sub bits {
  my $v = $_[1];

  use integer;
  no warnings 'portable'; # for 0xffffffffffffffff

  $v = $v - (($v >> 1) & 0x5555555555555555);
  $v = ($v & 0x3333333333333333) + (($v >> 2) & 0x3333333333333333);
  # (bytesof($v) -1) * bitsofbyte = (8-1)*8 = 56 ----------------------vv
  $v = (($v + ($v >> 4) & 0x0f0f0f0f0f0f0f0f) * 0x0101010101010101) >> 56;

  return $v;
}

sub combined_length {
  my ($self,$v1,$v2) = @_;

  return $self->bits($v1) + $self->bits($v2);
}

sub min {
  ($_[1] < $_[2])
    ? $_[1] : $_[2];
}

1;

__END__

=head1 NAME

Set::Similarity::BV - similarity measures for sets using fast bit vectors (BV)

=begin html

<a href="https://travis-ci.org/wollmers/Set-Similarity-BV"><img src="https://travis-ci.org/wollmers/Set-Similarity-BV.png" alt="Set-Similarity-BV"></a>
<a href='https://coveralls.io/r/wollmers/Set-Similarity-BV?branch=master'><img src='https://coveralls.io/repos/wollmers/Set-Similarity-BV/badge.png?branch=master' alt='Coverage Status' /></a>
<a href='http://cpants.cpanauthors.org/dist/Set-Similarity-BV'><img src='http://cpants.cpanauthors.org/dist/Set-Similarity-BV.png' alt='Kwalitee Score' /></a>
<a href="http://badge.fury.io/pl/Set-Similarity-BV"><img src="https://badge.fury.io/pl/Set-Similarity-BV.svg" alt="CPAN version" height="18"></a>

=end html

=head1 SYNOPSIS

 use Set::Similarity::BV::Dice;

 # object method
 my $dice = Set::Similarity::BV::Dice->new;
 my $similarity = $dice->similarity('af09ff','9c09cc');

 # class method
 my $dice = 'Set::Similarity::BV::Dice';
 my $similarity = $dice->similarity('af09ff','9c09cc');

=head1 DESCRIPTION

This is the base class including mainly helper and convenience methods.

=head2 Overlap coefficient

( A intersect B ) / min(A,B)

=head2 Jaccard Index

The Jaccard coefficient measures similarity between sample sets, and is defined as the size of the intersection divided by the size of the union of the sample sets

( A intersect B ) / (A union B)

The Tanimoto coefficient is the ratio of the number of features common to both sets to the total number of features, i.e.

( A intersect B ) / ( A + B - ( A intersect B ) ) # the same as Jaccard

The range is 0 to 1 inclusive.

=head2 Dice coefficient

The Dice coefficient is the number of features in common to both sets relative to the average size of the total number of features present, i.e.

( A intersect B ) / 0.5 ( A + B ) # the same as sorensen

The weighting factor comes from the 0.5 in the denominator. The range is 0 to 1.

=head1 METHODS

All methods can be used as class or object methods.

=head2 new

  $object = Set::Similarity::BV->new();

=head2 similarity

  my $similarity = $object->similarity($hex1,$hex2);

C<$hex> is a string of hexadecimal characters.

C<$width> must be integer, or defaults to 1.

=head2 from_integers

  my $similarity = $object->from_integers($int1,$int2);

Croaks if called directly. This method should be implemented in a child module.

=head2 intersection

  my $intersection_size = $object->intersection($int1,$int2);


=head2 combined_length

  my $set_size_sum = $object->combined_length($int1,$int2);

=head2 min

  my $min = $object->min($int1,$int2);

=head2 bits

  my $bits = $object->bits($int);

Returns the number of bits set in integer.


=head1 SEE ALSO

L<Set::Similarity::BV::Cosine>

L<Set::Similarity::BV::Dice>

L<Set::Similarity::BV::Jaccard>

L<Set::Similarity::BV::Overlap>


=head1 SOURCE REPOSITORY

L<http://github.com/wollmers/Set-Similarity-BV>

=head1 AUTHOR

Helmut Wollmersdorfer, E<lt>helmut.wollmersdorfer@gmail.comE<gt>

=begin html

<a href='http://cpants.cpanauthors.org/author/wollmers'><img src='http://cpants.cpanauthors.org/author/wollmers.png' alt='Kwalitee Score' /></a>

=end html

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016 by Helmut Wollmersdorfer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

