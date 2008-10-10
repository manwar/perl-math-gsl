%module "Math::GSL::Deriv"
// Danger Will Robinson, for realz!

%include "typemaps.i"
%include "gsl_typemaps.i"
%typemap(argout) (const gsl_function *f,
                       double x, double h,
                       double *result, double *abserr) {
    SV ** sv;
    //AV* av = newAV();

    sv = hv_fetch(Callbacks, (char*)&$input, sizeof($input), FALSE );
    if (sv == (SV**)NULL)
        croak("Math::GSL(argout) : Missing callback!\n");
    dSP;

    PUSHMARK(SP);
    // these are the arguments passed to the callback
    XPUSHs(sv_2mortal(newSViv((int)$2)));
    PUTBACK;

    /* This actually calls the perl subroutine */
    call_sv(*sv, G_SCALAR);    

    //av_push(av, newSVnv((double) *$4));
    //av_push(av, newSVnv((double) *$5));
    //$result = sv_2mortal( newRV_noinc( (SV*) av) );
    $result = sv_newmortal();
    sv_setnv($result, (double) *$4);
    argvi++;
    sv_setnv($result, (double) *$5);
    argvi++;

    if (argvi >= items) {            
        EXTEND(SP,1);              
    }

}

%typemap(in) void * {
    $1 = (double *) $input;
};
%{
    #include "gsl/gsl_math.h"
    #include "gsl/gsl_deriv.h"
%}

%include "gsl/gsl_math.h"
%include "gsl/gsl_deriv.h"

%perlcode %{
@EXPORT_OK = qw/
               gsl_deriv_central 
               gsl_deriv_backward 
               gsl_deriv_forward 
             /;
%EXPORT_TAGS = ( all => [ @EXPORT_OK ] );

__END__

=head1 NAME

Math::GSL::Deriv - Numerical Derivatives

=head1 SYNOPSIS

    use Math::GSL::Deriv qw/:all/;  
    use Math::GSL::Errno qw/:all/;

    my ($x, $h) = (1.5, 0.01);
    my ($status, $val,$err) = gsl_deriv_central ( sub {  sin($_[0]) }, $x, $h); 
    my $res = abs($val - cos($x));
    if ($status == $GSL_SUCCESS) {
        printf "deriv(sin((%g)) = %.18g, max error=%.18g\n", $x, $val, $err;  
        printf "       cos(%g)) = %.18g, residue=  %.18g\n"  , $x, cos($x), $res;
    } else {
        my $gsl_error = gsl_strerror($status);
        print "Numerical Derivative FAILED, reason:\n $gsl_error\n\n";
    }


=head1 DESCRIPTION

This module allows you to take the numerical derivative of a Perl subroutine. To find
a numerical derivative you must also specify a point to evaluate the derivative and a
"step size". The step size is a knob that you can turn to get a more finely or coarse
grained approximation. As the step size $h goes to zero, the formal definition of a
derivative is reached, but in practive you must choose a reasonable step size to get
a reasonable answer. Usually something in the range of 1/10 to 1/10000 is sufficient.

So long as your function returns a single scalar value, you can differentiate as 
complicated a function as your heart desires.

=over 

=item * C<gsl_deriv_central($function, $x, $h)> 

    use Math::GSL::Deriv qw/gsl_deriv_central/;
    my ($x, $h) = (1.5, 0.01);
    sub func { my $x=shift; $x**4 - 15 * $x + sqrt($x) };

    my ($status, $val,$err) = gsl_deriv_central ( \&func , $x, $h); 

    This method approximates the central difference of the subroutine reference
    $function, evaluated at $x, with "step size" $h. This means that the
    function is evaluated at $x-$h and $x+h.


=item * C<gsl_deriv_backward($function, $x, $h)> 

    use Math::GSL::Deriv qw/gsl_deriv_backward/;
    my ($x, $h) = (1.5, 0.01);
    sub func { my $x=shift; $x**4 - 15 * $x + sqrt($x) };

    my ($status, $val,$err) = gsl_deriv_backward ( \&func , $x, $h); 

    This method approximates the backward difference of the subroutine
    reference $function, evaluated at $x, with "step size" $h. This means that
    the function is evaluated at $x-$h and $x.

=item * C<gsl_deriv_forward($function, $x, $h)> 

    use Math::GSL::Deriv qw/gsl_deriv_forward/;
    my ($x, $h) = (1.5, 0.01);
    sub func { my $x=shift; $x**4 - 15 * $x + sqrt($x) };

    my ($status, $val,$err) = gsl_deriv_forward ( \&func , $x, $h); 

    This method approximates the forward difference of the subroutine reference
    $function, evaluated at $x, with "step size" $h. This means that the
    function is evaluated at $x and $x+$h.

=back

For more informations on the functions, we refer you to the GSL offcial
documentation: L<http://www.gnu.org/software/gsl/manual/html_node/>

=head1 AUTHORS

Jonathan Leto <jonathan@leto.net> and Thierry Moisan <thierry.moisan@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 Jonathan Leto and Thierry Moisan

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

%}

