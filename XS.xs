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
nsort(...)
    PROTOTYPE: @
    CODE:
        if (!items) {
            XSRETURN_UNDEF;
        }
        AV * array = newAV();
        int i;
        for (i=0; i<items; i++) {
            av_push(array, ST(i));
        }
        sortsv(AvARRAY(array), items, S_sv_ncmp);
        for (i=0; i<items; i++) {
            ST(i) = av_shift(array);
        }
        av_undef(array);
        SvREFCNT_dec(array);
        XSRETURN(items);
