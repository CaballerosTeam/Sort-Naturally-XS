package Sort::Naturally::XS;

use 5.010001;
use strict;
use warnings;
use Carp;

require Exporter;
use AutoLoader;

our @ISA = qw/Exporter/;

our @EXPORT = qw/ncmp nsort/;

our @EXPORT_OK = qw/sorted/;

our $VERSION = '0.7.2';

require XSLoader;
XSLoader::load('Sort::Naturally::XS', $VERSION);

sub sorted {
    my ($ar, %kwargs) = @_;

    Carp::confess('Not an ARRAY ref') if (ref $ar ne 'ARRAY');

    my $ar_copy = [@{$ar}];
    my $reverse = $kwargs{reverse} ? 1 : 0;
    my $locale = $kwargs{locale} || '';

    _sorted($ar_copy, $reverse, $locale);

    return $ar_copy;
}

# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Sort::Naturally::XS - Perl extension for human-friendly ("natural") sort order

=head1 SYNOPSIS

  use Sort::Naturally::XS;

  my @mixed_list = qw/test21 test20 test10 test11 test2 test1/;

  my @result = nsort(@mixed_list); # @result is: test1 test2 test10 test11 test20 test21

  @result = sort ncmp @mixed_list; # same, but use standard sort function

  @result = sort {ncmp($a, $b)} @mixed_list; # same as ncmp, but argument pass explicitly

=head1 DESCRIPTION

Natural sort order is an ordering of mixed (consists of characters and digits) strings in alphabetical order,
except that digits parts are ordered as a numbers. Natural sorting can be considered as a replacement for the standard
machine-oriented alphabetical sorting, because it more human-readable. For example, following list:

  test21 test20 test10 test11 test2 test1

after performing a standard machine-oriented alphabetical sorting, will be as follows:

  test1 test10 test11 test2 test20 test21

It isn't consistent, because test10 and test11 comes before test2. On the other hand, natural sorting gives
human-friendly sequence:

  test1 test2 test10 test11 test20 test21

now test2 comes before test10 and test11.

=head1 METHODS

=over 4

=item C<ncmp(LEFT, RIGHT)>

Replacement for the standard C<cmp> operator. LEFT and RIGHT elements to compare. Returns 1 if LEFT comes before
RIGHT, -1 if RIGHT comes before LEFT and 0 if LEFT and RIGHT are matched.

  # sort @list naturally, support in latest perl versions
  my @result = sort ncmp @list;

  # same, but arguments pass explicitly
  @result = sort {ncmp($a, $b)} @list;

  # more complex example, sort ARRAY of HASH refs by key 'foo' in descending order
  @result = sort {ncmp($b->{foo}, $a->{foo})} @list;

=item C<nsort(LIST)>

In list context returns sorted copy of LIST.

  my @result = nsort(@list);

=item C<sorted(ARRAY_REF, KWARGS)>

Returns an ARRAY ref to sorted list. First argument is an ARRAY ref to origin list, followed by keyword arguments,
such as C<reverse> or C<locale>. If C<reverse> is true origin list sorted in descending order. If C<locale> is
specified, performed locale aware sorting.

  use Sort::Naturally::XS qw/sorted/;

  my $result = sorted($list);

  $result = sorted($list, reverse => 1); # $list will be sorted in descending order

  $result = sorted($list, locale => 'en_US.utf8'); # $list will be sorted according to en_US.utf8 locale

=back


=head1 LOCALE AWARE SORTING

By default C<sort> sorts according to standard C locale or if C<use locale> pragma is in effect according to OS setting,
which can be changes by C<setlocale> function. Both C<use locale> and C<setlocale> has no effect on C<ncmp> and C<nsort>.
The following exmaple demonstrates this behavior:

  use POSIX;
  use Sort::Naturally::XS;

  my @list = ('a.'.'c', 'A'..'B');

  my @result_std = sort @list;
  my @result_ncmp = sort {ncmp($a, $b)} @list;
  # @result_std contains  A, B, C, a, b, c
  # @result_ncmp contains A, B, C, a, b, c

  use locale;
  # assumed that current locale is en_US.utf8
  @result_std = sort @list;
  @result_ncmp = sort {ncmp($a, $b)} @list;
  # @result_std contains  a, A, b, B, c, C
  # @result_ncmp contains A, B, C, a, b, c

  setlocale(POSIX::LC_ALL, 'en_CA.utf8');
  @result_std = sort @list;
  @result_ncmp = sort {ncmp($a, $b)} @list;
  # @result_std contains  A, a, B, b, C, c
  # @result_ncmp contains A, B, C, a, b, c

To be able to sort with arbitrary locale should used C<sorted> function with C<locale> keyword argument:

  use Sort::Naturally::XS qw/sorted/;

  my $list = ['a.'.'c', 'A'..'B'];

  my $result_us = sorted($list, locale => 'en_US.utf8');
  # $result_us contains a, A, b, B, c, C

  my $result_ca = sorted($list, locale => 'en_CA.utf8');
  # $result_ca contains A, a, B, b, C, c

Note: due to complexity of cross-platform support, locale aware sorting guaranteed only on Unix-like
operating systems

=head1 EXPORT

By default module exports C<ncmp> and C<nsort>q subroutines.

=head1 NOTES

=over 4

=item There are differences in comparison with the Sort::Naturally module

=item Due to significant overhead not recommended sorting lists consisting only of letters or only of digits

=item due to complexity of cross-platform support, locale aware sorting guaranteed only on Unix-like
operating systems

=back

=head1 SEE ALSO

L<Module repository|https://github.com/CaballerosTeam/Sort-Naturally-XS>

=head1 AUTHOR

Sergey Yurzin, L<jurzin.s@gmail.com|mailto:jurzin.s@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016 by Sergey Yurzin

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.18.2 or,
at your option, any later version of Perl 5 you may have available.

=cut
