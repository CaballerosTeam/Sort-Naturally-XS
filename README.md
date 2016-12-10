## NAME

Sort::Naturally::XS - Perl extension for human-friendly ("natural") sort order

## INSTALL

To install this module type the following:
```
   perl Makefile.PL
   make
   make test
   make install
```

## SYNOPSIS

```perl
  use Sort::Naturally::XS;

  my @mixed_list = qw/test21 test20 test10 test11 test2 test1/;

  my @result = nsort(@mixed_list); # @result is: test1 test2 test10 test11 test20 test21

  @result = sort ncmp @mixed_list; # same, but use standard sort function

  @result = sort {ncmp($a, $b)} @mixed_list; # same as ncmp, but argument pass explicitly
  
  my $result = Sort::Naturally::XS::sorted(\@mixed_list, locale => 'ru_RU.utf8'); # pass custom locale
```

## DESCRIPTION

Natural sort order is an ordering of mixed (consists of characters and digits) strings in alphabetical order,
except that digits parts are ordered as a numbers.

## EXPORT

By default module exports ncmp and nsort subroutines.

## NOTES

There are differences in comparison with the Sort::Naturally module.

## SEE ALSO

* [module on PrePAN](http://prepan.org/module/nYcMhBVby72)
* coming soon on CPAN

## AUTHOR

Sergey Yurzin, [jurzin.s@gmail.com](mailto:jurzin.s@gmail.com)

## COPYRIGHT AND LICENSE

Copyright (C) 2016 by Sergey Yurzin

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.18.2 or,
at your option, any later version of Perl 5 you may have available.
