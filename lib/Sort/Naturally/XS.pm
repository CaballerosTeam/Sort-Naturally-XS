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

our $VERSION = '0.7.3';

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
except that digits parts are ordered as a numbers.

=head2 EXPORT

By default module exports ncmp and nsort subroutines.

=head1 NOTES

There are differences in comparison with the Sort::Naturally module.


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
