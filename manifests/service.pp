# @api private
#
# This class is meant to be called from ephemeris to manage the ephemeris service.
#
class ephemeris::service {

  service { $::ephemeris::service_name:
    ensure     => $::ephemeris::service_ensure,
    enable     => $::ephemeris::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }
}
