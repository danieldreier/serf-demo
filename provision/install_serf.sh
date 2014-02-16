#!/bin/bash

hash serf && exit 0
iptables -F # don't put this into production...
cp /vagrant/serf/serf /usr/bin/
hash serf || echo "serf not in path"
