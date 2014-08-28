if $env == "dev" {
    include system::git
    include httpd::xdebug
}
include system::ntpd
include system::motd
include system::firewall
include system::ssh
include system::imagick
include system::composer
include system::hosts
include httpd
include httpd::zendopcache
include httpd::virtualhosts
include mariadb
include mariadb::createdb
include startup
include ezpublish
include ezpublish::ezfind
include ezpublish::install