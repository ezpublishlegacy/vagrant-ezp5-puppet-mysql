define ezpublish::install::fetch::git ($www, $ezpublish_src, $ezpublish_folder) {
  exec { "clone-ezpublish-community":
    command => "/usr/bin/git clone https://github.com/ezsystems/ezpublish-community.git $www/$ezpublish_folder",
    refreshonly => true,
    returns => [ 0, 1, 2, '', ' ']
  } ~>
  exec { "clone-ezpublish-legacy":
    command => "/usr/bin/git clone https://github.com/ezsystems/ezpublish-legacy.git ezpublish_legacy",
    cwd  => "$www/$ezpublish_folder",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:$www/$ezpublish_folder",
  } ~>
  exec { "composer-install":
    command => "/usr/bin/php /usr/local/bin/composer.phar install --prefer-dist",
    cwd  => "$www/$ezpublish_folder",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:$www/$ezpublish_folder",
  }
}