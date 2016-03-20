%module "Math::GSL::SF"
%include "typemaps.i"
%include "gsl_typemaps.i"
%include "renames.i"

%apply double *OUTPUT { double * sn, double * cn, double * dn, double * sgn };

// rename wrappers to original
//
%ignore gsl_sf_bessel_Jn_array;
%rename (gsl_sf_bessel_Jn_array) gsl_sf_bessel_Jn_array_wrapper;
array_wrapper* gsl_sf_bessel_Jn_array_wrapper(int nmin, int nmax, double x);

%ignore gsl_sf_bessel_Kn_array;
%rename (gsl_sf_bessel_Kn_array) gsl_sf_bessel_Kn_array_wrapper;
array_wrapper* gsl_sf_bessel_Kn_array_wrapper(int nmin, int nmax, double x);

%{
    #include "gsl/gsl_types.h"
    #include "gsl/gsl_version.h"
    #include "gsl/gsl_mode.h"
    #include "gsl/gsl_sf.h"
    #include "gsl/gsl_sf_airy.h"
    #include "gsl/gsl_sf_bessel.h"
    #include "gsl/gsl_sf_clausen.h"
    #include "gsl/gsl_sf_coulomb.h"
    #include "gsl/gsl_sf_coupling.h"
    #include "gsl/gsl_sf_dawson.h"
    #include "gsl/gsl_sf_debye.h"
    #include "gsl/gsl_sf_dilog.h"
    #include "gsl/gsl_sf_elementary.h"
    #include "gsl/gsl_sf_ellint.h"
    #include "gsl/gsl_sf_elljac.h"
    #include "gsl/gsl_sf_erf.h"
    #include "gsl/gsl_sf_exp.h"
    #include "gsl/gsl_sf_expint.h"
    #include "gsl/gsl_sf_fermi_dirac.h"
    #include "gsl/gsl_sf_gamma.h"
    #include "gsl/gsl_sf_gegenbauer.h"
    #include "gsl/gsl_sf_hyperg.h"
    #include "gsl/gsl_sf_laguerre.h"
    #include "gsl/gsl_sf_lambert.h"
    #include "gsl/gsl_sf_legendre.h"
    #include "gsl/gsl_sf_log.h"
    #include "gsl/gsl_sf_mathieu.h"
    #include "gsl/gsl_sf_pow_int.h"
    #include "gsl/gsl_sf_psi.h"
    #include "gsl/gsl_sf_result.h"
    #include "gsl/gsl_sf_synchrotron.h"
    #include "gsl/gsl_sf_transport.h"
    #include "gsl/gsl_sf_trig.h"
    #include "gsl/gsl_sf_zeta.h"

    /*  int gsl_sf_bessel_Jn_array (int nmin, int nmax, double x, double result_array[]) */
    array_wrapper* gsl_sf_bessel_Jn_array_wrapper(int nmin, int nmax, double x) {
        int ret;
        array_wrapper * wrapper = array_wrapper_alloc(nmax - nmin + 1, awDouble);
        ret = gsl_sf_bessel_Jn_array(nmin,nmax,x, (double*)(wrapper->data));
        if (ret)
           croak("Math::GSL::SF::gsl_sf_bessel_Jn_array returned failure");
        return wrapper;
    }

    /*  int gsl_sf_bessel_Kn_array (int nmin, int nmax, double x, double result_array[]) */
    array_wrapper* gsl_sf_bessel_Kn_array_wrapper(int nmin, int nmax, double x) {
        int ret;
        array_wrapper * wrapper = array_wrapper_alloc(nmax - nmin + 1, awDouble);
        ret = gsl_sf_bessel_Kn_array(nmin,nmax,x, (double*)(wrapper->data));
        if (ret)
           croak("Math::GSL::SF::gsl_sf_bessel_Kn_array returned failure");
        return wrapper;
    }


%}

%include "gsl/gsl_types.h"
%include "gsl/gsl_version.h"
%include "gsl/gsl_mode.h"
%include "gsl/gsl_sf.h"
%include "gsl/gsl_sf_airy.h"
%include "gsl/gsl_sf_bessel.h"
%include "gsl/gsl_sf_clausen.h"
%include "gsl/gsl_sf_coulomb.h"
%include "gsl/gsl_sf_coupling.h"
%include "gsl/gsl_sf_dawson.h"
%include "gsl/gsl_sf_debye.h"
%include "gsl/gsl_sf_dilog.h"
%include "gsl/gsl_sf_elementary.h"
%include "gsl/gsl_sf_ellint.h"
%include "gsl/gsl_sf_elljac.h"
%include "gsl/gsl_sf_erf.h"
%include "gsl/gsl_sf_exp.h"
%include "gsl/gsl_sf_expint.h"
%include "gsl/gsl_sf_fermi_dirac.h"
%include "gsl/gsl_sf_gamma.h"
%include "gsl/gsl_sf_gegenbauer.h"
%include "gsl/gsl_sf_hyperg.h"
%include "gsl/gsl_sf_laguerre.h"
%include "gsl/gsl_sf_lambert.h"
%include "gsl/gsl_sf_legendre.h"
%include "gsl/gsl_sf_log.h"
%include "gsl/gsl_sf_mathieu.h"
%include "gsl/gsl_sf_pow_int.h"
%include "gsl/gsl_sf_psi.h"
%include "gsl/gsl_sf_result.h"
%include "gsl/gsl_sf_synchrotron.h"
%include "gsl/gsl_sf_transport.h"
%include "gsl/gsl_sf_trig.h"
%include "gsl/gsl_sf_zeta.h"

%include "../pod/SF.pod"
