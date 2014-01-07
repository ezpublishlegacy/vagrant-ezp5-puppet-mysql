class system::motd {
    file    {'/etc/motd':
      ensure  => file,
      content => template('/tmp/vagrant-puppet/modules-0/system/manifests/files/motd.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '644',
    }
}