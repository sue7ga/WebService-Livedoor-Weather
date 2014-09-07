use strict;
use warnings;
use Carp;
use utf8;
use WebService::Livedoor::Weather;
use File::Spec;
use File::Basename 'dirname';
use lib (
   File::Spec->catdir(dirname(__FILE__),qw/.. lib/),
);

my $weather  = WebService::Livedoor::Weather->new();
my $content = $weather->get('旭川');

use Data::Dumper;
print  $content->{link};







