# -*- mode: ruby -*-
# vi: set ft=ruby :

# This is simply a baseline Vagrantfile that I seem to keep writing over and over
# Credit to https://github.com/patrickdlee/vagrant-examples for the more advanced syntax

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    ### Define options for all VMs ###
    # Using vagrant-cachier improves performance if you run repeated yum/apt updates
    if defined? VagrantPlugins::Cachier
      config.cache.auto_detect = true
    end
    config.vm.synced_folder "puppet", "/opt/puppet", id: "puppet-root"

#    config.vm.provision "shell", path: "provision/bootstrap_puppet.sh"
    config.ssh.forward_agent = true

    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512", "--cpus", "4", "--ioapic", "on"]
    end

    ### VM-Specific Options ###

    config.vm.define :centos64 do |node|
      node.vm.box = 'centos-64-x64-vbox4210-nocm'
      node.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210-nocm.box'

      node.vm.hostname = 'webserver-1.boxnet'
      node.vm.network :private_network, ip: "192.168.35.21"
      node.vm.provision "shell", path: "provision/install_puppet.sh"
      node.vm.provision "shell", path: "provision/bootstrap_puppet.sh"
    end

    config.vm.define :ubuntu1204 do |node|
      node.vm.box = 'ubuntu-server-12042-x64-vbox4210-nocm'
      node.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210-nocm.box'

      # hack to avoid ubuntu-specific 'stdin: is not a tty' error on startup
      node.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
      node.vm.provision "shell", path: "provision/install_puppet.sh"
      node.vm.provision "shell", path: "provision/bootstrap_puppet.sh"
    end

    config.vm.define :debian7 do |node|
      node.vm.box = 'debian-70rc1-x64-vbox4210-nocm'
      node.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/debian-70rc1-x64-vbox4210-nocm.box'
      # hack to avoid ubuntu-specific 'stdin: is not a tty' error on startup
      node.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
      node.vm.provision "shell", path: "provision/install_puppet.sh"
      node.vm.provision "shell", path: "provision/bootstrap_puppet.sh"
    end


end

