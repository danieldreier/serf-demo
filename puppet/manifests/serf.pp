class { 'serf':
  version => '0.4.1',
  bind    => $::ipaddress_eth1,
}

