node default {
  class { 'serf':
    # Note that this is using a hacked version of the serf module to allow
    # setting the "advertise" parameter. Submitted a pull request.
    version       => '0.4.1',
    bind          => $::ipaddress_eth1,
    advertise     => $::ipaddress_eth1,
    join          => [ $::first_node_ip ],
    event_handler => ['/vagrant/handler.sh'],
    rpc_addr      => '0.0.0.0:7373',
  }

  class { 'firewall': }
  resources { 'firewall':
    purge => true
  }
  Firewallchain {
    ensure => present,
    policy => 'accept',
    before => undef,
  }
  firewallchain { 'INPUT:filter:IPv4': }
  firewallchain { 'OUTPUT:filter:IPv4': }

}
