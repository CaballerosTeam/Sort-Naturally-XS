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
    return ncmp(ia, ib, 0);
}

static I32
S_sv_ncmp_reverse(pTHX_ SV *a, SV *b)
{
    const char *ia = (const char *) SvPVX(a);
    const char *ib = (const char *) SvPVX(b);
    return ncmp(ia, ib, 1);
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
    CODE:
        RETVAL = ncmp(arg_a, arg_b, 0);
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

SV *
_sorted(array_ref, reverse)
        SV *    array_ref
        int     reverse
    CODE:
        if (!SvROK(array_ref) || SvTYPE(SvRV(array_ref)) != SVt_PVAV) {
            croak("Not an ARRAY ref");
        }
        AV * array = (AV *) SvRV(array_ref);
        int array_len = av_top_index(array)+1;
        AV * result = newAV();
        int i;
        for (i=0; i<array_len; i++) {
            SV ** item = av_fetch(array, i, 0);
            if (item != NULL) {
                av_push(result, *item);
            }
        }
        if (reverse) {
            sortsv(AvARRAY(result), array_len, S_sv_ncmp_reverse);
        }
        else {
            sortsv(AvARRAY(result), array_len, S_sv_ncmp);
        }
        RETVAL = newRV((SV *) result);
        //SvREFCNT_dec(array);
    OUTPUT:
        RETVAL
