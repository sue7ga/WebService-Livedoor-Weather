use strict;
use warnings;
use utf8;
use Test::More;
use WebService::Livedoor::Weather;

my $weather = WebService::Livedoor::Weather->new();
my $content = $weather->get('旭川');

is($content->{link},'http://weather.livedoor.com/area/forecast/012010');
done_testing;