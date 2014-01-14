#!/bin/bash
set -e

cp /opt/puppet/puppet.conf /etc/puppet/puppet.conf
puppet apply -vv /vagrant/puppet/manifests/bootstrap.pp
