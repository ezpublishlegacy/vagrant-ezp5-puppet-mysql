class ezpublish {
    service { 'httpd':
      ensure => running,
      enable => true,
      before => Exec["prepare eZ Publish"],
      require => [File['/etc/httpd/conf.d/01.accept_pathinfo.conf'], File['/etc/httpd/conf.d/ezp5.conf']]
    } ~>
    exec    { "prepare eZ Publish":
      command => "/bin/bash /tmp/vagrant-puppet/manifests/preparezpublish.sh",
      path    => "/usr/local/bin/:/bin/",
      require => Package["httpd", "php", "php-cli", "php-gd" ,"php-mysql", "php-pear", "php-xml", "php-mbstring", "php-pecl-apc", "php-process", "curl.x86_64"]
    } ~>
    exec { "Fix Permissions":
      command => "/bin/chown -R apache:apache /var/www/html/",
      path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
    }
}