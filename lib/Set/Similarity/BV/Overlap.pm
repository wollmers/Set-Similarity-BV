package Set::Similarity::BV::Overlap;

use strict;
use warnings;

use parent 'Set::Similarity::BV';

our $VERSION = '0.03';

sub from_integers {
  my ($self, $v1, $v2) = @_;

  # ( A intersect B ) / min(A,B)
  return (
    $self->intersection($v1,$v2) / $self->min($self->bits($v1),$self->bits($v2))
  );
}

1;

__END__

=head1 NAME

Set::Similarity::BV::Overlap - Overlap coefficent for sets

=head1 SYNOPSIS

 use Set::Similarity::BV::Overlap;

 my $overlap = Set::Similarity::BV::Overlap->new;
 my $similarity = $overlap->similarity('af09ff','9c09cc');

=head1 DESCRIPTION

=head2 Overlap coefficient

( A intersect B ) / min(A,B)

=head1 METHODS

L<Set::Similarity::BV::Overlap> inherits all methods from L<Set::Similarity::BV> and implements the
following new ones.

=head2 from_integers

  my $similarity = $object->from_integers($int1,$int2);

This method expects two integers as parameters. The parameters are not checked, thus can lead to funny results or uncatched divisions by zero.

If you want to use this method directly, you should catch the situation where one of the integers is empty (similarity is 0), or both are empty (similarity is 1).

=head1 SOURCE REPOSITORY

L<http://github.com/wollmers/Set-Similarity-BV>

=head1 AUTHOR

Helmut Wollmersdorfer, E<lt>helmut.wollmersdorfer@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016 by Helmut Wollmersdorfer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut


