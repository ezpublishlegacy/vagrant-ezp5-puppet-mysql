class httpd::xdebug {
    exec    { "install xdebug":
      command => "pear install pecl/xdebug",
      path    => "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/vagrant/bin",
      require => Package['php-pear'],
      returns => [ 0, 1, '', ' ']
    }
    file    {'/etc/php.d/xdebug.ini':
      ensure  => file,
      content => template('/tmp/vagrant-puppet/manifests/php/xdebug.ini.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => '644',
      require => Package["php"],
    }
}