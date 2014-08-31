use strict;
use warnings;
use Test::More;
use Furl;
use WebService::Livedoor::Weather;
use Data::Dumper;

my $weather = WebService::Livedoor::Weather->new(furl => Furl->new);

my $content = $weather->get('東京');

subtest 'location' => {
  my $location = $content->{location};
  is($location->{city},'東京');
  is($location->{area},'関東'); 
  is($location->{area},'東京都'); 
};