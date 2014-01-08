define ezpublish::install::fetch::git ($www, $ezpublish_folder) {
  exec { "prepare eZ Publish":
    command => "/bin/bash /tmp/vagrant-puppet/modules-0/ezpublish/manifests/setup/preparezpublish.sh $www $ezpublish_folder",
    path    => "/usr/local/bin/:/bin/"
  }
}