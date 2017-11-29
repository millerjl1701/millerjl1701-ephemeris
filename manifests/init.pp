# Class: ephemeris
# ===========================
#
# Main class that includes all other classes for the ephemeris module.
#
# @param manage_python Whether or not to manage the installation of python, python-devel, pip, and virtualenv.
# @param manage_python_dev Whether the python class should have python-devel package as absent or present.
# @param manage_python_use_epel Whether or not the python class uses EPEL for installation of packages.
# @param manage_python_virtualenv Whether the python class should have the virtualenv package as absent or present.
# @param package_ensure Whether to install the ephemeris package, and/or what version. Values: 'present', 'latest', or a specific version number. Default value: present.
# @param package_name Specifies the name of the package to install. Default value: 'ephemeris'.
#
class ephemeris (
  Boolean     $manage_python            = true,
  String      $manage_python_dev        = 'present',
  Boolean     $manage_python_use_epel   = true,
  String      $manage_python_virtualenv = 'present',
  String      $package_ensure           = 'present',
  String      $package_name             = 'ephemeris',
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
