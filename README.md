# NAME

Set::Similarity::BV - similarity measures for sets using fast bit vectors (BV)

<div>
    <a href="https://travis-ci.org/wollmers/Set-Similarity-BV"><img src="https://travis-ci.org/wollmers/Set-Similarity-BV.png" alt="Set-Similarity-BV"></a>
    <a href='https://coveralls.io/r/wollmers/Set-Similarity-BV?branch=master'><img src='https://coveralls.io/repos/wollmers/Set-Similarity-BV/badge.png?branch=master' alt='Coverage Status' /></a>
    <a href='http://cpants.cpanauthors.org/dist/Set-Similarity-BV'><img src='http://cpants.cpanauthors.org/dist/Set-Similarity-BV.png' alt='Kwalitee Score' /></a>
    <a href="http://badge.fury.io/pl/Set-Similarity-BV"><img src="https://badge.fury.io/pl/Set-Similarity-BV.svg" alt="CPAN version" height="18"></a>
</div>

# SYNOPSIS

    use Set::Similarity::BV::Dice;

    # object method
    my $dice = Set::Similarity::BV::Dice->new;
    my $similarity = $dice->similarity('af09ff','9c09cc');

    # class method
    my $dice = 'Set::Similarity::BV::Dice';
    my $similarity = $dice->similarity('af09ff','9c09cc');

# DESCRIPTION

This is the base class including mainly helper and convenience methods.

## Overlap coefficient

( A intersect B ) / min(A,B)

## Jaccard Index

The Jaccard coefficient measures similarity between sample sets, and is defined as the size of the intersection divided by the size of the union of the sample sets

( A intersect B ) / (A union B)

The Tanimoto coefficient is the ratio of the number of features common to both sets to the total number of features, i.e.

( A intersect B ) / ( A + B - ( A intersect B ) ) # the same as Jaccard

The range is 0 to 1 inclusive.

## Dice coefficient

The Dice coefficient is the number of features in common to both sets relative to the average size of the total number of features present, i.e.

( A intersect B ) / 0.5 ( A + B ) # the same as sorensen

The weighting factor comes from the 0.5 in the denominator. The range is 0 to 1.

# METHODS

All methods can be used as class or object methods.

## new

    $object = Set::Similarity::BV->new();

## similarity

    my $similarity = $object->similarity($hex1,$hex2);

`$hex` is a string of hexadecimal characters.

`$width` must be integer, or defaults to 1.

## from\_integers

    my $similarity = $object->from_integers($int1,$int2);

Croaks if called directly. This method should be implemented in a child module.

## intersection

    my $intersection_size = $object->intersection($int1,$int2);

## combined\_length

    my $set_size_sum = $object->combined_length($int1,$int2);

## min

    my $min = $object->min($int1,$int2);

# SEE ALSO

[Set::Similarity::BV::Cosine](https://metacpan.org/pod/Set::Similarity::BV::Cosine)

[Set::Similarity::BV::Dice](https://metacpan.org/pod/Set::Similarity::BV::Dice)

[Set::Similarity::BV::Jaccard](https://metacpan.org/pod/Set::Similarity::BV::Jaccard)

[Set::Similarity::BV::Overlap](https://metacpan.org/pod/Set::Similarity::BV::Overlap)

# SOURCE REPOSITORY

[http://github.com/wollmers/Set-Similarity-BV](http://github.com/wollmers/Set-Similarity-BV)

# AUTHOR

Helmut Wollmersdorfer, &lt;helmut.wollmersdorfer@gmail.com>

<div>
    <a href='http://cpants.cpanauthors.org/author/wollmers'><img src='http://cpants.cpanauthors.org/author/wollmers.png' alt='Kwalitee Score' /></a>
</div>

# COPYRIGHT AND LICENSE

Copyright (C) 2016 by Helmut Wollmersdorfer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
