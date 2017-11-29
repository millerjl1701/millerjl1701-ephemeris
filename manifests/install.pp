# @api private
#
# This class manages the installion of python, pip, python-devel, and virtualenv.
#
class ephemeris::install {
  assert_private('ephemeris::install is a private class')

  if $ephemeris::manage_python {
    class { 'python':
      dev             => $ephemeris::manage_python_dev,
      manage_gunicorn => false,
      use_epel        => $ephemeris::manage_python_use_epel,
      virtualenv      => $ephemeris::manage_python_virtualenv,
    }
  }
}
