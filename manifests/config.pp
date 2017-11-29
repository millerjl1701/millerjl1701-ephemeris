# @api private
#
# This class is called from ephemeris for service config.
#
class ephemeris::config {
  assert_private('ephemeris::config is a private class')

  python::virtualenv { $ephemeris::virtualenv_dir:
    ensure => $ephemeris::virtualenv_ensure,
    owner  => $ephemeris::virtualenv_owner,
    group  => $ephemeris::virtualenv_group,
    mode   => $ephemeris::virtualenv_mode
  }
  #package { $::ephemeris::package_name:
  #  ensure =>  $::ephemeris::package_ensure,
  #}
}
