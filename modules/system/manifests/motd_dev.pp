class system::motd_dev {
    file    {'/etc/motd':
      ensure  => file,
      content => template('/tmp/vagrant-puppet/manifests/motd/motd.xdebug.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '644',
    }
}