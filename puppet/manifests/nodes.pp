# This is for a system where we'll be building CentOS 6 RPMs

node basenode {
  class { '::ntp':
    servers        => [ '0.north-america.pool.ntp.org',
                        '0.centos.pool.ntp.org',
                        'time.nist.gov',
                        'nist1-la.ustiming.org' ],
    restrict       => ['127.0.0.1'],
    service_ensure => 'running',
    service_enable => true,
  }

  # Install the basic sysadmin tools we often need
  $sysadmin_tools = [ 'man', 'screen', 'nc', 'mtr', 'iotop', 'git' ]
  case $operatingsystem {
    'RedHat', 'CentOS': {
      class { 'yum':
        extrarepo => [ 'epel' , 'puppetlabs' ],
      }
      package { $sysadmin_tools:
        ensure  => 'installed',
        require => Yumrepo['epel'],
      }
    }
    default: {
      package { $sysadmin_tools:
        ensure  => 'installed',
      }
    }
  }

  class { 'lsb': }

}

node default inherits basenode {

}
