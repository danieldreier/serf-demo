#!/bin/bash
set -e

mkdir -p /etc/puppet
cp /opt/puppet/puppet.conf /etc/puppet/puppet.conf
puppet apply -vv /vagrant/puppet/manifests/bootstrap.pp
