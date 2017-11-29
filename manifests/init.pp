# Class: ephemeris
# ===========================
#
# Main class that includes all other classes for the ephemeris module.
#
# @param manage_python Whether or not to manage the installation of python, python-devel, pip, and virtualenv.
# @param manage_python_dev Whether the python class should have python-devel package as absent or present.
# @param manage_python_use_epel Whether or not the python class uses EPEL for installation of packages.
# @param manage_python_virtualenv Whether the python class should have the virtualenv package as absent or present.
# @param virtualenv_dir Path for where the ephemeris virtualenv should be created.
# @param virtualenv_ensure Whether the ephemeris virtualenv should be present or absent.
# @param virtualenv_group Specifies the name of the group of the ephemeris virtualenv
# @param virtualenv_mode Specifies the mode of the ephemeris virtualenv.
# @param virtualenv_owner Specifies the name of the owner of the ephemeris virtualenv.
# @param virtualenv_requirements Specifies pip packages to add to the requirements.txt file for the ephemeris environment.
#
class ephemeris (
  Boolean                   $manage_python            = true,
  String                    $manage_python_dev        = 'present',
  Boolean                   $manage_python_use_epel   = true,
  String                    $manage_python_virtualenv = 'present',
  Stdlib::Absolutepath      $virtualenv_dir           = '/root/ephemeris',
  Enum['present', 'absent'] $virtualenv_ensure        = 'present',
  String                    $virtualenv_group         = 'root',
  String                    $virtualenv_mode          = '0750',
  String                    $virtualenv_owner         = 'root',
  Array                     $virtualenv_requirements  = [ 'ephemeris', 'bioblend', ],
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
