package Property::Lookup::File;
use 5.006;
use warnings;
use strict;
use File::Basename;
our $VERSION = '0.01';
use base 'Property::Lookup::Hash';
__PACKAGE__->mk_scalar_accessors(qw(filename));

sub init {
    my $self = shift;
    $self->SUPER::init(@_);
    if (my $conf_file = $self->filename) {

        # replace dollar-variables with their environment equivalent; also
        # some special definitions
        open my $fh, '<', $conf_file or die "can't open $conf_file: $!\n";
        my $yaml = do { local $/; <$fh> };
        close $fh or die "can't close $conf_file: $!\n";
        $ENV{SELF} = dirname($self->filename);
        $yaml =~ s/\$(\w+)/$ENV{$1} || "\$$1"/ge;
        require YAML;
        $self->hash(YAML::Load($yaml));
    }
}

1;
__END__

=head1 NAME

Property::Lookup::File - File-based property lookup layer

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

This class implements a file-based property lookup layer. It subclasses
L<Property::Lookup::Hash> but implements a custom C<init> method - see its
documentation.

=head1 METHODS

=over 4

=item C<init>

    my $layer = Property::Lookup::File->new(filename => 'conf.yaml');

If a C<filename> has been set, it uses L<YAML> to read that file. Before
parsing it, certain substitutions are performed:

The word C<SELF> is replaced by the path to the configuration file. This way
file names relative to the configuration file can be specified.

A dollar sign, followed by an identifier - one or more word characters - is
replaced by its equivalent value from the C<%ENV> hash.

Normally you will use this layer via the C<add_layer()> method from
L<Property::Lookup>.

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
