class system::hosts {
    file    {'/etc/hosts':
      ensure  => file,
      content => template('/tmp/vagrant-puppet/modules-0/system/manifests/files/hosts.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '644',
    }
}