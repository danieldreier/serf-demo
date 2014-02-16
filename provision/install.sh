#!/bin/bash

hash puppet && exit 0
hash serf && exit 0

yum -y install http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-10.noarch.rpm
yum -y install puppet
