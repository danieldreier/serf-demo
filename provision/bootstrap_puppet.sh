#!/bin/bash
set -e

cp /vagrant/provision/puppet.conf /etc/puppet/puppet.conf
puppet apply -vv /vagrant/puppet/manifests/bootstrap.pp
