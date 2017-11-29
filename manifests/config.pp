# @api private
#
# Class that configures the ephemeris virtualenv by installing pip packages.
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
  -> file { "${ephemeris::virtualenv_dir}/requirements.txt":
    ensure  => present,
    owner   => $ephemeris::virtualenv_owner,
    group   => $ephemeris::virtualenv_group,
    mode    => '0644',
    content => template('ephemeris/requirements.txt.erb'),
  }
  -> python::requirements { 'ephemeris_pip_requirements':
    requirements           => "${ephemeris::virtualenv_dir}/requirements.txt",
    virtualenv             => $ephemeris::virtualenv_dir,
    owner                  => $ephemeris::virtualenv_owner,
    group                  => $ephemeris::virtualenv_group,
    cwd                    => $ephemeris::virtualenv_dir,
    manage_requirements    => false,
    fix_requirements_owner => true,
    log_dir                => $ephemeris::virtualenv_dir,
  }
}
