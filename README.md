Vagrant-based Serf Demo
================

This is intended as the fastest way to get hands-on experience with [serf](http://www.serfdom.io/). This
is a wholesale copy of R.I. Pienaar's excellent [mcollective-vagrant](https://github.com/ripienaar/mcollective-vagrant) repo, which demonstrates mcollective.

How to use
----------

1. Install [Vagrant](http://vagrantup.com) and [VirtualBox](http://virtualbox.org)
2. Clone this repository: `git clone https://github.com/danieldreier/serf-demo.git`
3. `cd serf-demo` then run `vagrant up node0` and wait for the first node to start
4. `vagrant ssh -c 'serf monitor' node0` to monitor the communication the first node sees
5. in another terminal window, run `vagrant up` and watch members join the cluster
6. `vagrant ssh node1` then run `serf event foo bar` will trigger an event titled "foo" with a payload "bar"
7. On node1, run `serf members` to get a list of serf cluster members
8. `exit` out to your regular command line, run `vagrant halt node2`, then repeat step 7 to see cluster status

When you're done, run `vagrant halt` to shut them down, or `vagrant destroy` to remove the VMs entirely.

How it works
------------

The Vagrantfile uses puppet and the puppet-serf module to install serf, create a service for it, and configure it to try and connect to the ip address of the first node. In reality we could connect to any of the nodes, but this simplifies setup.

Caveats:

- The firewall is totally disabled on these boxes
- The action handler in /vagrant/handler.sh is a dummy that doesn't actually do anything
- The puppet-serf module is hacked to add support for the 'advertise' parameter; there's a pull request pending to add that upstream, but for now it's slightly different from what you'd get installing the puppet module
- Communication between nodes is totally insecure - this is for demo use only

You can modify the number of nodes created by editing `INSTANCES=3` in the Vagrantfile to some other value, then running `vagrant up` again to bring up the new nodes.
