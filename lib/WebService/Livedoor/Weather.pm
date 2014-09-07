package WebService::Livedoor::Weather;
use 5.008005;
use strict;
use warnings;
use LWP::UserAgent;
use Carp;
use XML::Simple;
use Furl;

use Class::Accessor::Lite::Lazy(
    new => 1,
    ro_lazy => [qw/furl/]
);

sub _build_furl{
    my $self = shift;
    $self->furl = Furl->new;
}

use constant BASE_URI => 'http://weather.livedoor.com/forecast';
use constant XML_URI => BASE_URI.'rss/primary_area.xml';
use constant JSON_URI => BASE_URI.'webservice/json/v1';

our $VERSION = "0.01";

sub get{
    my($self,$city) = @_;
    my $cityid = do{
        if($city =~ /\d+/)
            {return $city;}
        else
            { $self->_get_cityid($city);};
    };
    my $url = JSON_URI.'?city=$cityid';
    return $self->_parse_forecast($url);
}

sub _parse_forecast{
    my ($self,$url) = @_;
    my $res = $self->furl->get($url);
    return $self->_forecastmap($res->content); 
}

sub _forecastmap{
    my($self,$json) = @_;
    my $ref;
    eval{$ref = decode_json($json)};
    croak('failed reading weather information') if $@;
    return $ref;
}

sub _get_cityid{
    my($self,$cityname) = @_;
    my $response = $self->furl->get(XML_URI);
    $self->{citymap} = $self->_parse_citymap($response->content);
    return $self->{citymap}->{$cityname};
}

sub _parse_citymap{
    my($self,$content) = @_;
    my $ref = eval{
        local $XML::Simple::PREFERRED_PARSER = 'XML::Parser';
        XMLin($content,ForceArray => [qw/area city/]);
    };
    if($@){
        croak('Oh! failed reading forecastmap:'.$@);
    }
    my %city;
    foreach my $area(@{$ref->{channel}->{'ldWeather:source'}->{pref}}){
        $city{$area->{city}->{$_}->{title}} = $_ for keys %{$area->{city}};
    }
    return \%city;
}

1;


__END__

=encoding utf-8

=head1 NAME

WebService::Livedoor::Weather - It's new $module

=head1 SYNOPSIS

    use WebService::Livedoor::Weather;

=head1 DESCRIPTION

WebService::Livedoor::Weather is ...

=head1 LICENSE

Copyright (C) sue7ga.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

sue7ga E<lt>sue77ga@gmail.comE<gt>

=cut

