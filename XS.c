/*
 * This file was generated automatically by ExtUtils::ParseXS version 3.18 from the
 * contents of XS.xs. Do not edit this file, edit XS.xs instead.
 *
 *    ANY CHANGES MADE HERE WILL BE LOST!
 *
 */

#line 1 "XS.xs"
#define PERL_NO_GET_CONTEXT
#include "locale.h"
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
    return _ncmp(ia, ib, 0, 0);
}

static I32
S_sv_ncmp_reverse(pTHX_ SV *a, SV *b)
{
    const char *ia = (const char *) SvPVX(a);
    const char *ib = (const char *) SvPVX(b);
    return _ncmp(ia, ib, 1, 0);
}

static I32
S_sv_ncoll(pTHX_ SV *a, SV *b)
{
    const char *ia = (const char *) SvPVX(a);
    const char *ib = (const char *) SvPVX(b);
    return _ncmp(ia, ib, 0, 1);
}

static I32
S_sv_ncoll_reverse(pTHX_ SV *a, SV *b)
{
    const char *ia = (const char *) SvPVX(a);
    const char *ib = (const char *) SvPVX(b);
    return _ncmp(ia, ib, 1, 1);
}

#line 55 "XS.c"
#ifndef PERL_UNUSED_VAR
#  define PERL_UNUSED_VAR(var) if (0) var = var
#endif

#ifndef dVAR
#  define dVAR		dNOOP
#endif


/* This stuff is not part of the API! You have been warned. */
#ifndef PERL_VERSION_DECIMAL
#  define PERL_VERSION_DECIMAL(r,v,s) (r*1000000 + v*1000 + s)
#endif
#ifndef PERL_DECIMAL_VERSION
#  define PERL_DECIMAL_VERSION \
	  PERL_VERSION_DECIMAL(PERL_REVISION,PERL_VERSION,PERL_SUBVERSION)
#endif
#ifndef PERL_VERSION_GE
#  define PERL_VERSION_GE(r,v,s) \
	  (PERL_DECIMAL_VERSION >= PERL_VERSION_DECIMAL(r,v,s))
#endif
#ifndef PERL_VERSION_LE
#  define PERL_VERSION_LE(r,v,s) \
	  (PERL_DECIMAL_VERSION <= PERL_VERSION_DECIMAL(r,v,s))
#endif

/* XS_INTERNAL is the explicit static-linkage variant of the default
 * XS macro.
 *
 * XS_EXTERNAL is the same as XS_INTERNAL except it does not include
 * "STATIC", ie. it exports XSUB symbols. You probably don't want that
 * for anything but the BOOT XSUB.
 *
 * See XSUB.h in core!
 */


/* TODO: This might be compatible further back than 5.10.0. */
#if PERL_VERSION_GE(5, 10, 0) && PERL_VERSION_LE(5, 15, 1)
#  undef XS_EXTERNAL
#  undef XS_INTERNAL
#  if defined(__CYGWIN__) && defined(USE_DYNAMIC_LOADING)
#    define XS_EXTERNAL(name) __declspec(dllexport) XSPROTO(name)
#    define XS_INTERNAL(name) STATIC XSPROTO(name)
#  endif
#  if defined(__SYMBIAN32__)
#    define XS_EXTERNAL(name) EXPORT_C XSPROTO(name)
#    define XS_INTERNAL(name) EXPORT_C STATIC XSPROTO(name)
#  endif
#  ifndef XS_EXTERNAL
#    if defined(HASATTRIBUTE_UNUSED) && !defined(__cplusplus)
#      define XS_EXTERNAL(name) void name(pTHX_ CV* cv __attribute__unused__)
#      define XS_INTERNAL(name) STATIC void name(pTHX_ CV* cv __attribute__unused__)
#    else
#      ifdef __cplusplus
#        define XS_EXTERNAL(name) extern "C" XSPROTO(name)
#        define XS_INTERNAL(name) static XSPROTO(name)
#      else
#        define XS_EXTERNAL(name) XSPROTO(name)
#        define XS_INTERNAL(name) STATIC XSPROTO(name)
#      endif
#    endif
#  endif
#endif

/* perl >= 5.10.0 && perl <= 5.15.1 */


/* The XS_EXTERNAL macro is used for functions that must not be static
 * like the boot XSUB of a module. If perl didn't have an XS_EXTERNAL
 * macro defined, the best we can do is assume XS is the same.
 * Dito for XS_INTERNAL.
 */
#ifndef XS_EXTERNAL
#  define XS_EXTERNAL(name) XS(name)
#endif
#ifndef XS_INTERNAL
#  define XS_INTERNAL(name) XS(name)
#endif

/* Now, finally, after all this mess, we want an ExtUtils::ParseXS
 * internal macro that we're free to redefine for varying linkage due
 * to the EXPORT_XSUB_SYMBOLS XS keyword. This is internal, use
 * XS_EXTERNAL(name) or XS_INTERNAL(name) in your code if you need to!
 */

#undef XS_EUPXS
#if defined(PERL_EUPXS_ALWAYS_EXPORT)
#  define XS_EUPXS(name) XS_EXTERNAL(name)
#else
   /* default to internal */
#  define XS_EUPXS(name) XS_INTERNAL(name)
#endif

#ifndef PERL_ARGS_ASSERT_CROAK_XS_USAGE
#define PERL_ARGS_ASSERT_CROAK_XS_USAGE assert(cv); assert(params)

/* prototype to pass -Wmissing-prototypes */
STATIC void
S_croak_xs_usage(pTHX_ const CV *const cv, const char *const params);

STATIC void
S_croak_xs_usage(pTHX_ const CV *const cv, const char *const params)
{
    const GV *const gv = CvGV(cv);

    PERL_ARGS_ASSERT_CROAK_XS_USAGE;

    if (gv) {
        const char *const gvname = GvNAME(gv);
        const HV *const stash = GvSTASH(gv);
        const char *const hvname = stash ? HvNAME(stash) : NULL;

        if (hvname)
            Perl_croak(aTHX_ "Usage: %s::%s(%s)", hvname, gvname, params);
        else
            Perl_croak(aTHX_ "Usage: %s(%s)", gvname, params);
    } else {
        /* Pants. I don't think that it should be possible to get here. */
        Perl_croak(aTHX_ "Usage: CODE(0x%"UVxf")(%s)", PTR2UV(cv), params);
    }
}
#undef  PERL_ARGS_ASSERT_CROAK_XS_USAGE

#ifdef PERL_IMPLICIT_CONTEXT
#define croak_xs_usage(a,b)    S_croak_xs_usage(aTHX_ a,b)
#else
#define croak_xs_usage        S_croak_xs_usage
#endif

#endif

/* NOTE: the prototype of newXSproto() is different in versions of perls,
 * so we define a portable version of newXSproto()
 */
#ifdef newXS_flags
#define newXSproto_portable(name, c_impl, file, proto) newXS_flags(name, c_impl, file, proto, 0)
#else
#define newXSproto_portable(name, c_impl, file, proto) (PL_Sv=(SV*)newXS(name, c_impl, file), sv_setpv(PL_Sv, proto), (CV*)PL_Sv)
#endif /* !defined(newXS_flags) */

#line 197 "XS.c"

/* INCLUDE:  Including 'const-xs.inc' from 'XS.xs' */


XS_EUPXS(XS_Sort__Naturally__XS_constant); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_Sort__Naturally__XS_constant)
{
    dVAR; dXSARGS;
    if (items != 1)
       croak_xs_usage(cv,  "sv");
    PERL_UNUSED_VAR(ax); /* -Wall */
    SP -= items;
    {
#line 4 "./const-xs.inc"
#ifdef dXSTARG
	dXSTARG; /* Faster if we have it.  */
#else
	dTARGET;
#endif
	STRLEN		len;
        int		type;
	/* IV		iv;	Uncomment this if you need to return IVs */
	/* NV		nv;	Uncomment this if you need to return NVs */
	/* const char	*pv;	Uncomment this if you need to return PVs */
#line 222 "XS.c"
	SV *	sv = ST(0)
;
	const char *	s = SvPV(sv, len);
#line 18 "./const-xs.inc"
	type = constant(aTHX_ s, len);
      /* Return 1 or 2 items. First is error message, or undef if no error.
           Second, if present, is found value */
        switch (type) {
        case PERL_constant_NOTFOUND:
          sv =
	    sv_2mortal(newSVpvf("%s is not a valid Sort::Naturally::XS macro", s));
          PUSHs(sv);
          break;
        case PERL_constant_NOTDEF:
          sv = sv_2mortal(newSVpvf(
	    "Your vendor has not defined Sort::Naturally::XS macro %s, used",
				   s));
          PUSHs(sv);
          break;
	/* Uncomment this if you need to return IVs
        case PERL_constant_ISIV:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHi(iv);
          break; */
	/* Uncomment this if you need to return NOs
        case PERL_constant_ISNO:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHs(&PL_sv_no);
          break; */
	/* Uncomment this if you need to return NVs
        case PERL_constant_ISNV:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHn(nv);
          break; */
	/* Uncomment this if you need to return PVs
        case PERL_constant_ISPV:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHp(pv, strlen(pv));
          break; */
	/* Uncomment this if you need to return PVNs
        case PERL_constant_ISPVN:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHp(pv, iv);
          break; */
	/* Uncomment this if you need to return SVs
        case PERL_constant_ISSV:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHs(sv);
          break; */
	/* Uncomment this if you need to return UNDEFs
        case PERL_constant_ISUNDEF:
          break; */
	/* Uncomment this if you need to return UVs
        case PERL_constant_ISUV:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHu((UV)iv);
          break; */
	/* Uncomment this if you need to return YESs
        case PERL_constant_ISYES:
          EXTEND(SP, 1);
          PUSHs(&PL_sv_undef);
          PUSHs(&PL_sv_yes);
          break; */
        default:
          sv = sv_2mortal(newSVpvf(
	    "Unexpected return type %d while processing Sort::Naturally::XS macro %s, used",
               type, s));
          PUSHs(sv);
        }
#line 299 "XS.c"
	PUTBACK;
	return;
    }
}


/* INCLUDE: Returning to 'XS.xs' from 'const-xs.inc' */


XS_EUPXS(XS_Sort__Naturally__XS_ncmp); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_Sort__Naturally__XS_ncmp)
{
    dVAR; dXSARGS;
    if (items != 2)
       croak_xs_usage(cv,  "arg_a, arg_b");
    {
	const char *	arg_a = (const char *)SvPV_nolen(ST(0))
;
	const char *	arg_b = (const char *)SvPV_nolen(ST(1))
;
	int	RETVAL;
	dXSTARG;
#line 59 "XS.xs"
        RETVAL = _ncmp(arg_a, arg_b, 0, 0);
#line 324 "XS.c"
	XSprePUSH; PUSHi((IV)RETVAL);
    }
    XSRETURN(1);
}


XS_EUPXS(XS_Sort__Naturally__XS_nsort); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_Sort__Naturally__XS_nsort)
{
    dVAR; dXSARGS;
    PERL_UNUSED_VAR(cv); /* -W */
    {
#line 67 "XS.xs"
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
#line 353 "XS.c"
    }
    XSRETURN(1);
}


XS_EUPXS(XS_Sort__Naturally__XS__sorted); /* prototype to pass -Wmissing-prototypes */
XS_EUPXS(XS_Sort__Naturally__XS__sorted)
{
    dVAR; dXSARGS;
    if (items != 3)
       croak_xs_usage(cv,  "array_ref, reverse, locale");
    {
	SV *	array_ref = ST(0)
;
	int	reverse = (int)SvIV(ST(1))
;
	const char *	locale = (const char *)SvPV_nolen(ST(2))
;
#line 89 "XS.xs"
        if (!SvROK(array_ref) || SvTYPE(SvRV(array_ref)) != SVt_PVAV) {
            croak("Not an ARRAY ref");
        }
        AV * array = (AV *) SvRV(array_ref);
        int array_len = av_len(array) + 1;
        if (locale != NULL && strlen(locale)) {
            const char * old_locale = setlocale(LC_ALL, locale);
            if (reverse) {
                sortsv(AvARRAY(array), array_len, S_sv_ncoll_reverse);
            } else {
                sortsv(AvARRAY(array), array_len, S_sv_ncoll);
            }
            setlocale(LC_ALL, old_locale);
        } else {
            if (reverse) {
                sortsv(AvARRAY(array), array_len, S_sv_ncmp_reverse);
            } else {
                sortsv(AvARRAY(array), array_len, S_sv_ncmp);
            }
        }
#line 393 "XS.c"
    }
    XSRETURN_EMPTY;
}

#ifdef __cplusplus
extern "C"
#endif
XS_EXTERNAL(boot_Sort__Naturally__XS); /* prototype to pass -Wmissing-prototypes */
XS_EXTERNAL(boot_Sort__Naturally__XS)
{
    dVAR; dXSARGS;
#if (PERL_REVISION == 5 && PERL_VERSION < 9)
    char* file = __FILE__;
#else
    const char* file = __FILE__;
#endif

    PERL_UNUSED_VAR(cv); /* -W */
    PERL_UNUSED_VAR(items); /* -W */
#ifdef XS_APIVERSION_BOOTCHECK
    XS_APIVERSION_BOOTCHECK;
#endif
    XS_VERSION_BOOTCHECK;

        newXS("Sort::Naturally::XS::constant", XS_Sort__Naturally__XS_constant, file);
        newXS("Sort::Naturally::XS::ncmp", XS_Sort__Naturally__XS_ncmp, file);
        (void)newXSproto_portable("Sort::Naturally::XS::nsort", XS_Sort__Naturally__XS_nsort, file, "@");
        newXS("Sort::Naturally::XS::_sorted", XS_Sort__Naturally__XS__sorted, file);
#if (PERL_REVISION == 5 && PERL_VERSION >= 9)
  if (PL_unitcheckav)
       call_list(PL_scopestack_ix, PL_unitcheckav);
#endif
    XSRETURN_YES;
}

