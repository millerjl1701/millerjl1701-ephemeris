# Class: ephemeris
# ===========================
#
# Main class that includes all other classes for the ephemeris module.
#
# @param package_ensure [String] Whether to install the ephemeris package, and/or what version. Values: 'present', 'latest', or a specific version number. Default value: present.
# @param package_name [String] Specifies the name of the package to install. Default value: 'ephemeris'.
#
class ephemeris (
  String                     $package_ensure = 'present',
  String                     $package_name   = 'ephemeris',
  ) {
  case $::operatingsystem {
    'RedHat', 'CentOS': {
      contain ephemeris::install
      contain ephemeris::config

      Class['ephemeris::install']
      -> Class['ephemeris::config']
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
