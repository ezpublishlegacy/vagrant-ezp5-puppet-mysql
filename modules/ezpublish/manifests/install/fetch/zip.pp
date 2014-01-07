define ezpublish::install::fetch::zip ($www, $ezpublish_src, $ezpublish_folder, $ezpublish) {
  exec { "download-zip":
    command => "/usr/bin/wget $ezpublish_src -O $www/$ezpublish",
  } ~>
  exec { "create_folder_tar":
    command => "/bin/mkdir $www/$ezpublish_folder",
    refreshonly => true,
    returns => [ 0, 1, 2, '', ' ']
  } ~>
  exec { "extract_zip":
    command => "/bin/zip --strip-components=1 -xzf $www/$ezpublish -C $www/$ezpublish_folder",
    refreshonly => true,
    returns => [ 0, 1, 2, '', ' ']
  }
}