class system::motd {
    file    {'/etc/motd':
      ensure  => file,
      content => template('/tmp/vagrant-puppet/manifests/motd/motd.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '644',
    }
}