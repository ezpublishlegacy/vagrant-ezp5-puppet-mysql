class system::hosts {
    file    {'/etc/hosts':
      ensure  => file,
      content => template('/tmp/vagrant-puppet/manifests/hosts/hosts.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '644',
    }
}