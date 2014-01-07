define ezpublish::install::fetch::git ($www, $ezpublish_folder) {
  exec { "clone-ezpublish-community":
    command => "/usr/bin/git clone https://github.com/ezsystems/ezpublish-community.git $www/$ezpublish_folder",
    returns => [ 0, 1, 2, '', ' ']
  } ~>
  exec { "clone-ezpublish-legacy":
    command => "/usr/bin/git clone https://github.com/ezsystems/ezpublish-legacy.git ezpublish_legacy",
    cwd     => "$www/$ezpublish_folder",
    path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:$www/$ezpublish_folder",
    require => Exec["clone-ezpublish-community"],
    returns => [ 0, 128 ]
  } ~>
  exec { "composer-install":
    command => "/usr/bin/php /usr/local/bin/composer.phar install --prefer-dist",
    cwd     => "$www/$ezpublish_folder",
    path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:$www/$ezpublish_folder",
    require => Exec["clone-ezpublish-community"],
    before  => [Exec["assets_install"], Exec["legacy_assets"], Exec["assetic_dump"], Exec["regenerateautoloads"]],
    returns => [ 0, 1 ]
  }
}