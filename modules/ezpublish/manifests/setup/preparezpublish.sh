#!/bin/bash

WWW=$1
EZPUBLISH_FOLDER=$2


function geteZPublish-Community {
    cd $WWW
    /usr/bin/git clone https://github.com/ezsystems/ezpublish-community.git $WWW/$EZPUBLISH_FOLDER
}

function geteZPublish-Legacy {
    cd $WWW/$EZPUBLISH_FOLDER
    /usr/bin/git clone https://github.com/ezsystems/ezpublish-legacy.git ezpublish_legacy
}

function composer-install {
    cd $WWW/$EZPUBLISH_FOLDER
    COMPOSER_HOME="$WWW/$EZPUBLISH_FOLDER" /usr/bin/php /usr/local/bin/composer.phar install --prefer-dist
}

if [ ! -d $WWW/$EZPUBLISH_FOLDER ]; then
    geteZPublish-Community
    geteZPublish-Legacy
    composer-install
fi