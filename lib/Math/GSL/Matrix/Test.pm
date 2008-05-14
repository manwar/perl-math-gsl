package Math::GSL::Matrix::Test;
use base q{Test::Class};
use Test::More;
use Math::GSL::Matrix qw/:all/;
use Math::GSL qw/is_similar/;
use Data::Dumper;
use strict;

sub make_fixture : Test(setup) {
    my $self = shift;
    $self->{matrix} = gsl_matrix_alloc(5,5);

}

sub teardown : Test(teardown) {
}

sub GSL_MATRIX_ALLOC : Tests {
    my $matrix = gsl_matrix_alloc(5,5);
    isa_ok($matrix, 'Math::GSL::Matrix');
}

sub GSL_MATRIX_SET : Tests {
    my $self = shift;
    map { gsl_matrix_set($self->{matrix}, $_,$_, $_ ** 2) } (0..4);
    isa_ok( $self->{matrix}, 'Math::GSL::Matrix' );

    my @got = map { gsl_matrix_get($self->{matrix}, $_, $_) } (0..4);

    map { ok(is_similar($got[$_], $_ ** 2)) } (0..4);

}
1;