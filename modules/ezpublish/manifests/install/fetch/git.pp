define ezpublish::install::fetch::git ($www, $ezpublish_folder) {
  exec { "prepare eZ Publish":
    command => "ezpublish/preparezpublish.sh $www $ezpublish_folder",
    path    => "/usr/local/bin/:/bin/",
    timeout => 0
  }
}