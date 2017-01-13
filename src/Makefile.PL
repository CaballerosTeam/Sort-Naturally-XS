use ExtUtils::MakeMaker;

$Verbose = 1;

WriteMakefile(
	NAME    => 'Sort::Naturally::XS::ncmp',
	SKIP    => [ qw(all static static_lib dynamic dynamic_lib) ],
	clean   => { 'FILES' => 'libnsort$(LIB_EXT)' },
	CCFLAGS => '`pkg-config --libs --cflags icu-uc icu-io`',
);

sub MY::top_targets {
'
all :: static
pure_all :: static
static ::       libnsort$(LIB_EXT)
libnsort$(LIB_EXT): $(O_FILES)
		$(AR) cr libnsort$(LIB_EXT) $(O_FILES)
		$(RANLIB) libnsort$(LIB_EXT)
';
}
