use strict;
use warnings;
use Test::More;
use Sort::Naturally::XS;

my $ar = [qw/test21 test20 test10 test11 test2 test1/];
my $ar_copy = [qw/test21 test20 test10 test11 test2 test1/];
my $ar_expexted = [qw/test1 test2 test10 test11 test20 test21/];
my $result = Sort::Naturally::XS::sorted($ar);

ok(eq_array($ar_expexted, $result), 'array sorted');
ok(eq_array($ar_copy, $ar), 'original array not changed');

$result = Sort::Naturally::XS::isorted($ar);
ok(eq_array($ar_expexted, $result), '2 array sorted');
ok(eq_array($ar_copy, $ar), '2 original array not changed');

done_testing();
