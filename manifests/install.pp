# @api private
#
# This class is called from the main ephemeris class for install.
#
class ephemeris::install {
  package { $::ephemeris::package_name:
    ensure => $::ephemeris::package_ensure,
  }
}
