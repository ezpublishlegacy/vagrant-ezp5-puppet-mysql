class mariadb {
    $neededpackages = [ "mariadb", "mariadb-server"]
    package { $neededpackages:
      ensure => installed
    } ~>
    service { "mariadb":
      ensure => running,
      hasstatus => true,
      hasrestart => true,
      require => Package["mariadb-server"],
      restart => true;
    }
}