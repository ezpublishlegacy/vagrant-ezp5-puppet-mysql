class ezpublish::install {
  $www = '/var/www/html'
  $ezpublish_src = 'http://share.ez.no/content/download/154571/912584/version/1/file/ezpublish5_community_project-2013.11-gpl-full.tar.gz'
  $ezpublish_folder = 'ezpublish5'
  $ezpublish = 'ezpublish.tar.gz'
  $type = 'tar' # This can be tar, zip or git if you're using base_xdedug
  ezpublish::install::fetch{ 'fetch':
    www => $www, 
    ezpublish_src => $ezpublish_src, 
    ezpublish_folder => $ezpublish_folder, 
    ezpublish => $ezpublish, 
    type => $type
  } ->
  exec { "setfacl-R":
    command => "/usr/bin/setfacl -R -m u:apache:rwx -m u:apache:rwx $www/$ezpublish_folder/ezpublish/{cache,logs,config} $www/$ezpublish_folder/ezpublish_legacy/{design,extension,settings,var} web",
    onlyif  => '/usr/bin/test -d $www/$ezpublish_folder',
    returns => [ 1 ]
  } ->
  exec { "setfacl-dR":
    command => "/usr/bin/setfacl -dR -m u:apache:rwx -m u:vagrant:rwx $www/$ezpublish_folder/ezpublish/{cache,logs,config} $www/$ezpublish_folder/ezpublish_legacy/{design,extension,settings,var} web",
    onlyif  => '/usr/bin/test -d $www/$ezpublish_folder',
    returns => [ 0, 1, 2, '', ' ']
  } ->
  exec { "remove_cache":
    command => "/bin/rm -rf $www/$ezpublish_folder/ezpublish/cache/*",
    onlyif  => '/usr/bin/test -d $www/$ezpublish_folder'
  } ->
  file { "$www/$ezpublish_folder/ezpublish/config/ezpublish_prod.yml":
    ensure  => file,
    content => template('/tmp/vagrant-puppet/modules-0/ezpublish/manifests/setup/ezpublish_prod.yml.erb'),
    owner   => 'apache',
    group   => 'apache',
    mode    => '666',
  } ->
  file { "$www/$ezpublish_folder/ezpublish/config/ezpublish_dev.yml":
    ensure => file,
    content => template('/tmp/vagrant-puppet/modules-0/ezpublish/manifests/setup/ezpublish_prod.yml.erb'),
    owner   => 'apache',
    group   => 'apache',
    mode    => '666',
  } ->
  file { "$www/$ezpublish_folder/ezpublish/config/ezpublish.yml":
    ensure => file,
    content => template('/tmp/vagrant-puppet/modules-0/ezpublish/manifests/setup/ezpublish.yml.erb'),
    owner   => 'apache',
    group   => 'apache',
    mode    => '666',
  } ->
  exec { "assets_install":
    command => "/usr/bin/php $www/$ezpublish_folder/ezpublish/console assets:install --symlink $www/$ezpublish_folder/web",
    onlyif  => '/usr/bin/test -d $www/$ezpublish_folder',
  } ->
  exec { "legacy_assets":
    command => "/usr/bin/php $www/$ezpublish_folder/ezpublish/console ezpublish:legacy:assets_install --symlink $www/$ezpublish_folder/web",
    onlyif  => '/usr/bin/test -d $www/$ezpublish_folder',
  } ~>
  exec { "assetic_dump":
    command => "/usr/bin/php $www/$ezpublish_folder/ezpublish/console assetic:dump",
    onlyif  => '/usr/bin/test -d $www/$ezpublish_folder',
  } ~>
  exec { "create_folders":
    command => "/bin/mkdir -p $www/$ezpublish_folder/ezpublish_legacy/settings/override && /bin/mkdir -p $www/$ezpublish_folder/ezpublish_legacy/settings/siteaccess/eng && /bin/mkdir -p $www/$ezpublish_folder/ezpublish_legacy/settings/siteaccess/ezdemo_site && /bin/mkdir -p $www/$ezpublish_folder/ezpublish_legacy/settings/siteaccess/ezdemo_site_admin",
    returns => [ 0, 1, 2, '', ' ']
  } ~>
  file { "$www/$ezpublish_folder/ezpublish_legacy/settings/override/site.ini.append.php":
    ensure  => file,
    content => template('/tmp/vagrant-puppet/modules-0/ezpublish/manifests/setup/override_site.ini.append.php.erb'),
    owner   => 'apache',
    group   => 'apache',
    mode    => '666',
  } ->
  file { "$www/$ezpublish_folder/ezpublish_legacy/settings/siteaccess/eng/site.ini.append.php":
    ensure  => file,
    content => template('/tmp/vagrant-puppet/modules-0/ezpublish/manifests/setup/ezdemo_site.ini.append.php.erb'),
    owner   => 'apache',
    group   => 'apache',
    mode    => '666',
  } ->
  file { "$www/$ezpublish_folder/ezpublish_legacy/settings/siteaccess/ezdemo_site/site.ini.append.php":
    ensure  => file,
    content => template('/tmp/vagrant-puppet/modules-0/ezpublish/manifests/setup/ezdemo_site.ini.append.php.erb'),
    owner   => 'apache',
    group   => 'apache',
    mode    => '666',
  } ->
  file { "$www/$ezpublish_folder/ezpublish_legacy/settings/siteaccess/ezdemo_site_admin/site.ini.append.php":
    ensure  => file,
    content => template('/tmp/vagrant-puppet/modules-0/ezpublish/manifests/setup/admin_site.ini.append.php.erb'),
    owner   => 'apache',
    group   => 'apache',
    mode    => '666',
  } ->
  exec { "kernel_schema":
    command => "/usr/bin/mysql -uezp -pezp ezp < $www/$ezpublish_folder/ezpublish_legacy/kernel/sql/mysql/kernel_schema.sql",
    returns => [ 0, 1, '', ' ']
  } ->
  exec { "cleandata":
    command => "/usr/bin/mysql -uezp -pezp ezp < $www/$ezpublish_folder/ezpublish_legacy/kernel/sql/common/cleandata.sql",
    returns => [ 0, 1, '', ' ']
  } ->
  exec { "regenerateautoloads":
    command => "/usr/bin/php bin/php/ezpgenerateautoloads.php --extension",
    cwd  => "$www/$ezpublish_folder/ezpublish_legacy",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:$www/$ezpublish_folder",
  }
}