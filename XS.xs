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
END

int
nsort(arg_a, arg_b)
        const char *    arg_a
        const char *    arg_b
    OUTPUT:
        RETVAL
