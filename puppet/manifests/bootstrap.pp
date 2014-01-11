node default {

case $operatingsystem {
    'RedHat', 'CentOS': {
      exec { 'yum update on first boot':
        command => '/usr/bin/yum --exclude=kernel* update -y',
        creates => '/var/first-boot-update-ran',
      }
      file {'/var/first-boot-update-ran':
        content => 'yum update ran on first boot',
        require => Exec['yum update on first boot'],
      }
    }
    default: {
    }
  }

  package { 'rubygems': ensure => 'installed' }
  package { 'librarian-puppet':
    ensure   => 'installed',
    provider => 'gem',
    require  => Package['rubygems'],
  }

  # Run librarian-puppet if Puppetfile changed
  file { '/etc/puppet/Puppetfile':
    mode   => '0644',
    owner  => root,
    group  => root,
    source => '/vagrant/Puppetfile';
  }

  exec { 'run librarian-puppet':
    environment => ['HOME=/root'],
    command     => '/usr/bin/librarian-puppet install',
    cwd         => '/etc/puppet',
    refreshonly => true,
    subscribe   => File['/etc/puppet/Puppetfile'],
    path        => '/usr/bin:/usr/sbin:/bin',
    require     => [ File['/etc/puppet/Puppetfile'],
                    Package['librarian-puppet'], ],
  }



}
