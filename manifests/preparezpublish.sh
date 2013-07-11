#!/bin/bash

WWW=/var/www/html
EZPUBLISH=http://share.ez.no/content/download/151343/893911/version/1/file/ezpublish5_community_project-2013.06-gpl-full.tar.gz

function geteZPublish {
    cd $WWW
    /usr/bin/wget $EZPUBLISH
}

function extracteZPublish {
    cd $WWW
    /bin/tar xzf ezpublish5_community_project-2013.06-gpl-full.tar.gz
}

function rename {
    cd $WWW
    /bin/mv /var/www/html/ezpublish5_community_project-2013.6-gpl-full/ /var/www/html/ezpublish5
}

function preparePermissions {
    cd $WWW/ezpublish5
    /usr/bin/setfacl -R -m u:apache:rwx -m u:apache:rwx ezpublish/{cache,logs,config} ezpublish_legacy/{design,extension,settings,var} web
    /usr/bin/setfacl -dR -m u:apache:rwx -m u:vagrant:rwx ezpublish/{cache,logs,config} ezpublish_legacy/{design,extension,settings,var} web
}

function assets {
    cd $WWW/ezpublish5
    /usr/bin/php ezpublish/console assets:install --symlink web
    /usr/bin/php ezpublish/console ezpublish:legacy:assets_install --symlink web
    /usr/bin/php ezpublish/console assetic:dump --env=prod web
}

geteZPublish
extracteZPublish
rename
preparePermissions
assets
