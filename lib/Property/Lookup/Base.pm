package Property::Lookup::Base;
use 5.006;
use warnings;
use strict;
our $VERSION = '0.01';
use base qw(Class::Accessor::Constructor);
__PACKAGE__->mk_constructor;

# Define functions and class methods lest they be handled by AUTOLOAD.
sub DEFAULTS               { () }
sub FIRST_CONSTRUCTOR_ARGS { () }
sub DESTROY                { }

# Each lookup layer should answer any call, so return undef for all options
# unknown to this layer.
sub AUTOLOAD { }
1;
__END__

=head1 NAME

Property::Lookup::Base - Base class for property lookup classes

=head1 SYNOPSIS

    use Property::Lookup;

    my %opt;
    GetOptions(\%opt, '...');

    my $config = Property::Lookup->new;
    $config->add_layer(file => 'conf.yaml');
    $config->add_layer(getopt => \%opt);
    $config->default_layer({
        foo => 23,
    });

    my $foo = $config->foo;

    # ...

    use Property::Lookup::Local;
    local %Property::Lookup::Local::opt = (bar => 'baz');

=head1 DESCRIPTION

This is the base class for property lookup layers.

=head1 METHODS

=over 4

=item C<DEFAULTS>

This accessor is used by L<Class::Accessor::Constructor>. It is defined as an
empty list here so C<AUTOLOAD> won't try to handle it.

=item C<FIRST_CONSTRUCTOR_ARGS>

This accessor is used by L<Class::Accessor::Constructor>. It is defined as an
empty list here so C<AUTOLOAD> won't try to handle it.

=back

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests through the web interface at
L<http://rt.cpan.org>.

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit L<http://www.perl.com/CPAN/> to find a CPAN
site near you. Or see L<http://search.cpan.org/dist/Property-Lookup/>.

The development version lives at L<http://github.com/hanekomu/property-lookup/>.
Instead of sending patches, please fork this project using the standard git
and github infrastructure.

=head1 AUTHORS

Marcel GrE<uuml>nauer, C<< <marcel@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2009 by Marcel GrE<uuml>nauer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
