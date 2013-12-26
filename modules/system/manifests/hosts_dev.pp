class system::hosts_dev {
    file    {'/etc/hosts':
      ensure  => file,
      content => template('/tmp/vagrant-puppet/manifests/hosts/hosts.xdebug.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '644',
    }
}