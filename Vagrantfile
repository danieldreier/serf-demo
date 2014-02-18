# -*- mode: ruby -*-
# vi: set ft=ruby :

# Shamelessly copied from https://github.com/ripienaar/mcollective-vagrant/blob/master/Vagrantfile
# Inspired by discussion at https://github.com/hashicorp/serf/issues/127

# create this many nodes
INSTANCES=5

# Nodes will be called node1.example.net, node2.example.net, etc.
DOMAIN="example.net"

# these nodes do not need a lot of RAM - 128 is barely enough
# increase it if you want to run anything else on these boxes
MEMORY=128

# the instances is a hostonly network, this will
# be the prefix to the subnet they use
SUBNET="192.168.2"

Vagrant.configure("2") do |config|
  config.vm.provision :puppet, :options => ["--pluginsync"], :module_path => "deploy/modules", :facter => { "first_node_ip" => "#{SUBNET}.10" } do |puppet|
    puppet.manifests_path = "deploy"
    puppet.manifest_file = "site.pp"
  end
  if defined? VagrantPlugins::Cachier
    config.cache.auto_detect = true
  end
  if defined?(VagrantPlugins::ProviderVirtualBox::Action::CheckGuestAdditions)
    config.vbguest.auto_update = false
  end

  INSTANCES.times do |i|
    config.vm.define "node#{i}".to_sym do |vmconfig|
      vmconfig.vm.box = 'ubuntu-server-12042-x64-vbox4210'
      vmconfig.vm.network :private_network, ip: "#{SUBNET}.%d" % (10 + i)
      vmconfig.vm.provider :virtualbox do |vb|
          vb.customize ["modifyvm", :id, "--memory", MEMORY]
      end
      vmconfig.vm.host_name = "node%d.#{DOMAIN}" % i
      vmconfig.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box'
    end
  end
end
