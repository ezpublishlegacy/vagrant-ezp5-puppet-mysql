include ntpd
include apache2php
include db
include createdb
include xdebug
include imagick
include ezfind
include virtualhosts
include firewall
include composer
include prepareezpublish
include motd
include addhosts

class ntpd {
    package { "ntpdate": 
              ensure => installed 
            }
    service { "ntpd":
              ensure => running,
    }
}

class motd {
    file    {'/etc/motd':
              ensure  => file,
              content => template('/tmp/vagrant-puppet/manifests/motd/motd.erb'),
              owner   => 'root',
              group   => 'root',
              mode    => '644',
            }
}

class apache2php {
    exec    { "update-ubuntun":
              command => '/usr/bin/apt-get update',
              path    => "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/vagrant/bin",
            }
    $neededpackages = [ "apache2", "php5", "php5-cli", "php5-gd" ,"php5-mysql", "php-pear", "php5-xmlrpc", "php5-cgi", "php-apc", "php5-fpm", "php5-xdebug", "curl" ]
    package { $neededpackages:
               ensure => installed,
            }
    file    {'/etc/apache2/conf.d/01.accept_pathinfo.conf':
              ensure  => file,
              content => template('/tmp/vagrant-puppet/manifests/apache/01.accept_pathinfo.conf.erb'),
              owner   => 'root',
              group   => 'root',
              mode    => '644',
            }
    file    {'/etc/php.d/php.ini':
              ensure  => file,
              content => template('/tmp/vagrant-puppet/manifests/php/php.ini.erb'),
              owner   => 'root',
              group   => 'root',
              mode    => '644',
            }
}

class imagick {
    $neededpackages = [ "imagemagick", "php5-imagick" ]
    package { $neededpackages:
              ensure => installed,
              require  => Package["apache2", "php5", "php5-cli", "php5-gd" ,"php5-mysql", "php-pear", "php5-xmlrpc", "php5-cgi", "php-apc", "php5-fpm", "php5-xdebug", "curl"]
            }
    exec    { "update-channels":
              command => "pear update-channels",
              path    => "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/vagrant/bin",
              require => Package['php-pear'],
              returns => [ 0, 1, '', ' ']
            } ~>
    exec    { "install imagick":
              command => "pecl install imagick",
              path    => "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/vagrant/bin",
              require => Package['php-pear'],
              returns => [ 0, 1, '', ' ']
            }
}

class db {
    $neededpackages = [ "mysql", "mysql-server"]
    package { $neededpackages:
              ensure => installed,
              require  => Package["apache2", "php5"]
            }
    file    {'/etc/mysql/my.cnf':
              ensure  => file,
              content => template('/tmp/vagrant-puppet/manifests/mysql/my.cnf.erb'),
              owner   => 'root',
              mode    => '644',
            }
    service { "mysql":
	      ensure => running,
	      hasstatus => true,
	      hasrestart => true,
	      require => Package["mysql-server"],
	      restart => true;
	    }
}

class createdb {
    exec { "create-ezp-db":
        command => "/usr/bin/mysql -uroot -e \"create database ezp character set utf8; grant all on ezp.* to ezp@localhost identified by 'ezp';\"",
        require => Service["mysql"],
	returns => [ 0, 1, '', ' ']
    }
}

class xdebug {
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
              require => Package["php5"],
            }
}

class ezfind {
    $neededpackages = [ "openjdk-6-jre" ]
    package { $neededpackages:
              ensure => installed,
              require => Package["apache2"],
            }
}

class virtualhosts {
    file    {'/etc/apache2/conf.d/02.namevirtualhost':
              ensure  => file,
              content => template('/tmp/vagrant-puppet/manifests/virtualhost/02.namevirtualhost.conf.erb'),
              owner   => 'root',
              group   => 'root',
              mode    => '644',
              require => Package["apache2"],
            }
    file    {'/etc/apache2/conf.d/ezp5':
              ensure  => file,
              content => template('/tmp/vagrant-puppet/manifests/virtualhost/ezp5.conf.erb'),
              owner   => 'root',
              group   => 'root',
              mode    => '644',
              require => Package["apache2"],
            }
}

class firewall {
    file    {'/etc/iptables.rules':
              ensure  => file,
              content => template('/tmp/vagrant-puppet/manifests/iptables/iptables.erb'),
              owner   => 'root',
              group   => 'root',
              mode    => '600',
            } ~>
    service { iptables:
              ensure => running,
              subscribe => File["/etc/iptables.rules"],
            }
}

class composer {
    exec    { "get composer":
               command => "curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin",
               path    => "/usr/local/bin:/usr/bin/",
               require => Service["apache2"],
               returns => [ 0, 1, '', ' ']
            } ~>
    exec    { "link composer":
               command => "/bin/ln -s /usr/local/bin/composer.phar /usr/local/bin/composer.phar",
               path    => "/usr/local/bin:/usr/bin/:/bin",
               returns => [ 0, 1, '', ' ']
            }
}

class prepareezpublish {
    exec    { "prepare eZ Publish":
              command => "/bin/bash /tmp/vagrant-puppet/manifests/preparezpublish.sh",
              path    => "/usr/local/bin/:/bin/",
              require => Package["apache2", "php5", "php5-cli", "php5-gd" ,"php5-mysql", "php-pear", "php5-xmlrpc", "php5-cgi", "php-apc", "php5-fpm", "php5-xdebug", "curl"]
            } ~>
    service { 'apache2':
              ensure => running,
              enable => true,
            }
}

class addhosts {
    file    {'/etc/hosts':
              ensure  => file,
              content => template('/tmp/vagrant-puppet/manifests/hosts/hosts.erb'),
              owner   => 'root',
              group   => 'root',
              mode    => '644',
            }
}
