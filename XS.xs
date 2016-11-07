#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "src/nsort.h"

#include "const-c.inc"

MODULE = Sort::Naturally::XS		PACKAGE = Sort::Naturally::XS		

INCLUDE: const-xs.inc

TYPEMAP: <<END
const char *    T_PV
charArray *     T_ARRAY
END

int
ncmp(arg_a, arg_b)
        const char *    arg_a
        const char *    arg_b
    OUTPUT:
        RETVAL


charArray *
nsort(array, ...)
        charArray *     array
    PREINIT:
        int size_RETVAL;
    CODE:
        size_RETVAL = ix_array;
        nsort(array, ix_array);
        RETVAL = array;
    OUTPUT:
        RETVAL
    CLEANUP:
        XSRETURN(size_RETVAL);
