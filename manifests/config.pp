# @api private
#
# This class is called from ephemeris for service config.
#
class ephemeris::config {
  assert_private('ephemeris::config is a private class')

  #package { $::ephemeris::package_name:
  #  ensure =>  $::ephemeris::package_ensure,
  #}
}
