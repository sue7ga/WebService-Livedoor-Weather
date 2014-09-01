use strict;
use warnings;
use Data::Dumper;
use Carp;
use FindBin;
use Furl;
use utf8;
use WebService::Livedoor::Weather;
use lib "$FindBin::Bin/../lib";

my $weather  = WebService::Livedoor::Weather->new(furl => Furl->new);

my $content = $weather->get('東京');

print Encode::encode_utf8($content->{location}->{prefecture});





