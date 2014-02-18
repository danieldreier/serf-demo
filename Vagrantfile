# -*- mode: ruby -*-
# vi: set ft=ruby :

# Shamelessly copied from https://github.com/ripienaar/mcollective-vagrant/blob/master/Vagrantfile
# Inspired by discussion at https://github.com/hashicorp/serf/issues/127

<<<<<<< HEAD

# create this many nodes
INSTANCES=3

# the nodes will be called middleware.example.net
# and node0.example.net, you can change this here
DOMAIN="example.net"

# these nodes do not need a lot of RAM, 384 is
# is enough but you can tweak that here
MEMORY=256
=======
# create this many nodes
INSTANCES=5

# Nodes will be called node1.example.net, node2.example.net, etc.
DOMAIN="example.net"

# these nodes do not need a lot of RAM - 128 is barely enough
# increase it if you want to run anything else on these boxes
MEMORY=128
>>>>>>> 4d3a2a6f1f707dbf4c680818b6a171d340bf8f67

# the instances is a hostonly network, this will
# be the prefix to the subnet they use
SUBNET="192.168.2"

<<<<<<< HEAD

=======
>>>>>>> 4d3a2a6f1f707dbf4c680818b6a171d340bf8f67
Vagrant.configure("2") do |config|
#  config.vm.provision "shell", path: "provision/install.sh"
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
