# @api private
#
# This class is called from ephemeris for service config.
#
class ephemeris::config {
  assert_private('ephemeris::config is a private class')

  $_requirements = $ephemeris::virtualenv_requirements

  python::virtualenv { $ephemeris::virtualenv_dir:
    ensure => $ephemeris::virtualenv_ensure,
    owner  => $ephemeris::virtualenv_owner,
    group  => $ephemeris::virtualenv_group,
    mode   => $ephemeris::virtualenv_mode
  }
  -> file { "$ephemeris::virtualenv_dir/requirements.txt":
    ensure  => present,
    owner   => $ephemeris::virtualenv_owner,
    group   => $ephemeris::virtualenv_group,
    mode    => '0644',
    content => template('ephemeris/requirements.txt.erb'),
  }
}
