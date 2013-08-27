package Lintian::ruby;

use strict;
use warnings;

use Lintian::Collect::Binary ();
use Lintian::Tags qw(tag);

sub run {
    my $pkg = shift;
    my $type = shift;
    my $info = shift;

    if ($type eq 'binary') {

        my $pkg_description = $info->field('description');
        if ($pkg_description) {
          if ($pkg =~ /^lib.*-ruby.*/ and !$info->is_pkg_class('transitional') ) {
            tag 'ruby-library-old-package-name-schema';
          }
        }

        my $str_deps = $info->relation('strong');
        if ($str_deps and $str_deps->implies("ruby1.8")) {
            tag 'ruby-depends-on-ruby1.8';
        }

        if ($str_deps and $str_deps->matches(qr/^ruby[0-9.]+$/o) and !$str_deps->implies("ruby1.8")) {
            tag 'ruby-depends-on-specific-ruby-version';
        }
    }
}

1;
# Local Variables:
# indent-tabs-mode: nil
# cperl-indent-level: 4
# End:
# vim: syntax=perl sw=4 sts=4 sr et
