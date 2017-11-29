# @api private
#
# This class is called from the main ephemeris class for install.
#
class ephemeris::install {
  if $ephemeris::manage_python {
    class { 'python':
      dev             => $ephemeris::manage_python_dev,
      manage_gunicorn => false,
      use_epel        => $ephemeris::manage_python_use_epel,
      virtualenv      => $ephemeris::manage_python_virtualenv,
    }
  }
}
