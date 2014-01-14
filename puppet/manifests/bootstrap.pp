# Bootstrap librarian puppet

node default {
  # Install librarian-puppet
  package { 'rubygems': ensure => 'installed' }
  package { 'librarian-puppet':
    ensure   => 'installed',
    provider => 'gem',
    require  => Package['rubygems'],
  }

  # Hack because librarian-puppet fails in a virtualbox shared file system
  file { '/etc/puppet/Puppetfile':
    mode   => '0644',
    source => '/opt/puppet/Puppetfile',
  }

  # Run librarian-puppet only if Puppetfile changed
  exec { 'run librarian-puppet':
    environment => ['HOME=/root'],
    command     => 'librarian-puppet install',
    cwd         => '/etc/puppet',
    refreshonly => true,
    subscribe   => File['/etc/puppet/Puppetfile'],
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    require     => [ File['/etc/puppet/Puppetfile'],
                    Package['librarian-puppet'], ],
  }
}
