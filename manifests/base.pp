case $env {
    "prod": {
        include system::ntpd
        include system::motd
        include system::firewall
        include system::ssh
        include system::imagick
        include system::composer
        include system::hosts
        include httpd
        include httpd::apc
        include httpd::virtualhosts
        include mysql
        include mysql::createdb
        include startup
        include ezpublish
        include ezpublish::ezfind
        include ezpublish::install
    }
    "dev": {
        include system::ntpd
        include system::motd_dev
        include system::git
        include system::firewall
        include system::ssh
        include system::imagick
        include system::composer
        include system::hosts_dev
        include httpd
        include httpd::apc
        include httpd::virtualhosts_dev
        include mysql
        include mysql::createdb
        include startup
        include ezpublish
        include ezpublish::ezfind
        include ezpublish::install
    }
    default: {
        include system::ntpd
        include system::motd_dev
        include system::git
        include system::firewall
        include system::ssh
        include system::imagick
        include system::composer
        include system::hosts_dev
        include httpd
        include httpd::apc
        include httpd::virtualhosts_dev
        include mysql
        include mysql::createdb
        include startup
        include ezpublish
        include ezpublish::ezfind
        include ezpublish::install
    }
}