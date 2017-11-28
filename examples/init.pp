node default {

  notify { 'enduser-before': }
  notify { 'enduser-after': }

  class { 'ephemeris':
    require => Notify['enduser-before'],
    before  => Notify['enduser-after'],
  }

}
