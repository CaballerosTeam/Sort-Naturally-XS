#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "src/nsort.h"

#include "const-c.inc"

static I32
S_sv_ncmp(pTHX_ SV *a, SV *b)
{
    const char *ia = (const char *) SvPVX(a);
    const char *ib = (const char *) SvPVX(b);
    return ncmp(ia, ib);
}

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

void
nsort(ar_ref)
        SV *    ar_ref;
    PREINIT:
        AV *    ar;
    CODE:
        if (!SvRV(ar_ref) || SvTYPE(SvRV(ar_ref)) != SVt_PVAV) {
            croak("Not an ARRAY ref");
        }
        ar = (AV *) SvRV(ar_ref);
        sortsv(AvARRAY(ar), av_top_index(ar)+1, S_sv_ncmp);
