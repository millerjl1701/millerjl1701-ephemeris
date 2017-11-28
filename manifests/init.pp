# Class: ephemeris
# ===========================
#
# Main class that includes all other classes for the ephemeris module.
#
# @param package_ensure [String] Whether to install the ephemeris package, and/or what version. Values: 'present', 'latest', or a specific version number. Default value: present.
# @param package_name [String] Specifies the name of the package to install. Default value: 'ephemeris'.
# @param service_enable [Boolean] Whether to enable the ephemeris service at boot. Default value: true.
# @param service_ensure [Enum['running', 'stopped']] Whether the ephemeris service should be running. Default value: 'running'.
# @param service_name [String] Specifies the name of the service to manage. Default value: 'ephemeris'.
#
class ephemeris (
  String                     $package_ensure = 'present',
  String                     $package_name   = 'ephemeris',
  Boolean                    $service_enable = true,
  Enum['running', 'stopped'] $service_ensure = 'running',
  String                     $service_name   = 'ephemeris',
  ) {
  case $::operatingsystem {
    'RedHat', 'CentOS': {
      contain ephemeris::install
      contain ephemeris::config
      contain ephemeris::service

      Class['ephemeris::install']
      -> Class['ephemeris::config']
      ~> Class['ephemeris::service']
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
