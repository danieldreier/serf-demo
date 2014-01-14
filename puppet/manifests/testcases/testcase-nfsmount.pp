# Test case for PUP-1415
# Requires the haraldsk/nfs module which librarian-puppet has problems installing
# Tested on Centos 6.4
# Basic tests of nfs export, mount, and operations on a root_squash'd NFS mount

include nfs::server
nfs::server::export{ '/export/repo':
  ensure  => 'mounted',
  #clients => '10.0.0.0/24(rw,insecure,async,no_root_squash) localhost(rw)',
  clients => '10.0.0.0/24(rw,insecure,async,root_squash) localhost(rw)',
  require => File['/export/repo'],
}

file { '/testrepo':
  ensure => 'directory',
}

file { [ '/export', '/export/repo' ]:
  ensure => 'directory',
}

file { '/export/repo/anybodycanwrite':
  ensure => 'directory',
  mode   => '0777',
  require => File['/export/repo'],
}

file { '/testrepo/anybodycanwrite/nfstest.sh':
  ensure => 'present',
  mode   => '0555',
  content => "#!/bin/bash \n date > /tmp/currentdate",
  require => File['/export/repo/anybodycanwrite'],
}

exec { '/testrepo/anybodycanwrite/nfstest.sh': 
  require => File['/testrepo/anybodycanwrite/nfstest.sh'],
}

mount { 'repomount':
  ensure  => 'mounted',
  name    => '/testrepo',
  device  => 'localhost:/export/repo',
  fstype  => 'nfs',
  options => 'defaults',
  atboot  => true,
  require => [ Package['nfs-utils'], File['/testrepo'] ],
}

