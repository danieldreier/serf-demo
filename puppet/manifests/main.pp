# script to run puppet
file{"/usr/local/bin/runpuppet":
  content => " \
  sudo puppet apply -vv /vagrant/puppet/manifests/main.pp\n",
  mode    => 0755
}

# script to run librarian-puppet
file{"/usr/local/bin/runlibrarian":
  content => "cd /etc/puppet && sudo librarian-puppet update --verbose\n",
  mode    => 0755
}

import 'basic.pp'
import 'nodes.pp'
