use strict;
use warnings;
use Test::More;
use Sort::Naturally::XS;

my $ar = [qw/test21 test20 test10 test11 test2 test1/];
my $ar_copy = [@{$ar}];
my $ar_expected = [qw/test1 test2 test10 test11 test20 test21/];
my $result = Sort::Naturally::XS::sorted($ar);

ok(eq_array($ar_expected, $result), 'Array sorted asceding');
ok(eq_array($ar_copy, $ar), 'Original array not changed after ascending sort');

$ar_expected = [reverse(@{$ar_expected})];
$result = Sort::Naturally::XS::sorted($ar, reverse => 1);

ok(eq_array($ar_expected, $result), 'Array sorted descending');
ok(eq_array($ar_copy, $ar), 'Original array not changed after descending');

done_testing();
