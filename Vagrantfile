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

    config.vm.define :centos64_2725 do |node|
      node.vm.box = 'centos-64-x64-vbox4210-nocm'
      node.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210-nocm.box'
      node.vm.hostname = 'centos-64-2725.boxnet'

      node.vm.network :private_network, ip: "192.168.35.21"
      node.vm.provision "shell", path: "provision/install_puppet.sh", args: "2.7.25"
      node.vm.provision "shell", path: "provision/bootstrap_puppet.sh"
    end

    config.vm.define :centos64_latest do |node|
      node.vm.box = 'centos-64-x64-vbox4210-nocm'
      node.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210-nocm.box'
      node.vm.hostname = 'centos-64-latest.boxnet'

      node.vm.network :private_network, ip: "192.168.35.24"
      node.vm.provision "shell", path: "provision/install_puppet.sh"
      node.vm.provision "shell", path: "provision/bootstrap_puppet.sh"
    end

    config.vm.define :fedora18_latest do |node|
      node.vm.box = 'fedora-18-x64-vbox4210-nocm'
      node.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/fedora-18-x64-vbox4210-nocm.box'
      node.vm.hostname = 'fedora-18-latest.boxnet'

      node.vm.provision "shell", path: "provision/install_puppet.sh"
      node.vm.provision "shell", path: "provision/bootstrap_puppet.sh"
    end
    config.vm.define :fedora18_2725 do |node|
      node.vm.box = 'fedora-18-x64-vbox4210-nocm'
      node.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/fedora-18-x64-vbox4210-nocm.box'
      node.vm.hostname = 'fedora-18-2725.boxnet'

      node.vm.provision "shell", path: "provision/install_puppet.sh", args: "2.7.25"
      node.vm.provision "shell", path: "provision/bootstrap_puppet.sh"
    end

    config.vm.define :ubuntu1204_latest do |node|
      node.vm.box = 'ubuntu-server-12042-x64-vbox4210-nocm'
      node.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210-nocm.box'
      node.vm.hostname = 'ubuntu-1204.boxnet'
      node.vm.network :private_network, ip: "192.168.35.22"

      # hack to avoid ubuntu/debian-specific 'stdin: is not a tty' error on startup
      node.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

      node.vm.provision "shell", path: "provision/install_puppet.sh"
      node.vm.provision "shell", path: "provision/bootstrap_puppet.sh"
    end

    config.vm.define :ubuntu1204_2725 do |node|
      node.vm.box = 'ubuntu-server-12042-x64-vbox4210-nocm'
      node.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210-nocm.box'
      node.vm.hostname = 'ubuntu-1204-2725.boxnet'
      node.vm.network :private_network, ip: "192.168.35.28"

      # hack to avoid ubuntu/debian-specific 'stdin: is not a tty' error on startup
      node.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

      node.vm.provision "shell", path: "provision/install_puppet.sh", args: "2.7.25"
      node.vm.provision "shell", path: "provision/bootstrap_puppet.sh"
    end


    config.vm.define :debian7_latest do |node|
      node.vm.box = 'debian-70rc1-x64-vbox4210-nocm'
      node.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/debian-70rc1-x64-vbox4210-nocm.box'
      node.vm.hostname = 'debian7.boxnet'
      node.vm.network :private_network, ip: "192.168.35.23"

      # hack to avoid ubuntu/debian-specific 'stdin: is not a tty' error on startup
      node.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

      node.vm.provision "shell", path: "provision/install_puppet.sh"
      node.vm.provision "shell", path: "provision/bootstrap_puppet.sh"
    end

    config.vm.define :debian7_2725 do |node|
      node.vm.box = 'debian-70rc1-x64-vbox4210-nocm'
      node.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/debian-70rc1-x64-vbox4210-nocm.box'
      node.vm.hostname = 'debian7.boxnet'
      node.vm.network :private_network, ip: "192.168.35.26"

      # hack to avoid ubuntu/debian-specific 'stdin: is not a tty' error on startup
      node.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

      node.vm.provision "shell", path: "provision/install_puppet.sh", args: "2.7.25"
      node.vm.provision "shell", path: "provision/bootstrap_puppet.sh"
    end

    config.vm.define :arch_latest do |node|
      node.vm.box = 'arch64'
      node.vm.box_url = 'http://iweb.dl.sourceforge.net/project/flowboard-vagrant-boxes/arch64-2013-07-26-minimal.box'
      node.vm.provision "shell", path: "provision/install_puppet.sh"

      # Librarian-puppet does not auto-install correctly on arch
      #node.vm.provision "shell", path: "provision/bootstrap_puppet.sh"
    end


end

