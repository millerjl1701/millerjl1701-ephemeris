# @api private
#
# This class is called from the main ephemeris class for install.
#
class ephemeris::install {
  if $ephemeris::manage_python {
    class { 'python':
      dev             => 'present',
      manage_gunicorn => false,
      use_epel        => false,
      virtualenv      => 'present',
    }
  }
}
