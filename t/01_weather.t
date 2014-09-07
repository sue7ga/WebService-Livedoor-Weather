use strict;
use warnings;
use Test::More;
use Furl;
use WebService::Livedoor::Weather;
use utf8;

my $weather = WebService::Livedoor::Weather->new();

my $content = $weather->get('旭川');

subtest 'location' => sub{
  my $location = $content->{location};
  is($location->{city},'旭川');
  is($location->{area},'北海道'); 
  is($location->{prefecture},'北海道'); 
};


done_testing;