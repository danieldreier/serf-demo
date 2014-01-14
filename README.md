vagrant-template
================

Vagrant template for setting up puppet-provisioned systems

This repository contains a self-contained puppet install bash script that installs arbitrary versions of puppet on multiple distributions, a bash script and puppet manifest that install librarian-puppet on (most of) those distributions, and a Vagrantfile that shows how to use it.

The intent is for this to replace the one-off scripts that I kept writing to get puppet and puppet modules installed somewhere. I currently use it to facilitate multi-distro and multi-puppet-version manifest testing.

Reasons to use this instead of a simple 5 line script to do the same thing:

- all status messages are test results, not just where you are in the script
- works the same across multiple distros
- installs wget and other dependencies as necessary using native package management
- does not depend on LSB packages for distro detection, to work on common disk images that don't include it
- can be re-run without errors or wasting time - nothing gets re-run without tests first
- pulls the puppetlabs GPG key securely (on CentOS) rather than using the typical no-ssl / no GPG verification approach

How to use
----------

1. Install Vagrant and VirtualBox
2. Fork / clone this repository
3. modify `puppet/Puppetfile` for the puppet modules you need
4. modify the Vagrantfile for the distros and puppet version(s) you need
5. `vagrant up`

I've been using this to test the same thing across a bunch of different environments. The easiest way to do that is to simply add another Vagrant provisioner that kicks off your tested item after the existing provisioners ran. For example, I've used this together with a compile script and fpm to quickly create packages of whatever software in multiple distributions.
