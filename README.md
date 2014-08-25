# vagrant:ezp5:puppet:mariadb:centos7

Prototype development machine for eZ Publish 5.x, provisioned with Puppet.

## Stack & utilities:

- CentOS 7.0 x64
- Apache 2.4.6
- MariaDB 5.5.37
- PHP 5.4.16
- APC 3.1.13
- Xdebug 2.2.5 or not, this is your choice through Vagrantfile setup
- Composer
- Git or not, this is your choice throught Vagrantfile setup
- eZ Publish 5 Community 2014.07 ( Installed and ready to use or GIT )

## Requirements:

- Vagrant (http://vagrantup.com)
- VirtualBox (https://www.virtualbox.org/) or VMWare (http://www.vmware.com/)

## Getting started:

The following steps will setup a Cent Os 7.0 based VM for development with eZ Publish 2014.07 pre-installed.
There are to possible processes, the first one you'll clone the repository while the second one you'll download it and extract it without needing to have the git tools installed:

### A. Cloning the repository

- Clone this project to a directory 

```
$ git clone git@github.com:cleverti/vagrant-ezp5-puppet-mariadb-centos7.git

$ cd vagrant-ezp5-puppet-mariadb-centos7
```

### B. Downloading the repository

- Download: https://github.com/cleverti/vagrant-ezp5-puppet-mariadb-centos7/archive/master.zip
- Extract the file to a desired location
- Open your console and make sure you are inside the extracted folder

```
$ cd vagrant-ezp5-puppet-mariadb-centos7
```

### Common steps

- Run `$ vagrant up` from the terminal
- Wait (the first time will take a few minutes, as the base box is downloaded, and required packages are installed for the first time), get some coffee.
- Done! `$ vagrant ssh` to SSH into your newly created machine. The MOTD contains details on the database, hostnames, etc.
- By default Xdebug is disabled, if you want to enable it, go to line 64 and change from "prod" to "dev". Don't forget to run `$ vagrant up` after

## Access your site

- Open your browser on http://localhost:8080

## SSH into VM

You'll have to be inside your folder (vagrant-ezp5-puppet-mariadb-centos7

```
$ vagrant ssh
```

or

```
$ ssh vagrant@localhost -p2222

Password: vagrant
```

## Shutdown the VM

You'll have to be inside your folder (vagrant-ezp5-puppet-mariadb-centos7)

```
$ vagrant halt
```

## Rebuild

You'll have to be inside your folder (vagrant-ezp5-puppet-mariadb-centos7)

```
$ vagrant destroy

$ vagrant up
```

## Default Environment Details:

```
MySQL:
  default database: ezp
  default db user: ezp
  default db user password: ezp

Apache/httpd: www root: /var/www/html

eZ Publish 5 Project:
  location: /var/www/html/ezpublish5
  hostname: ezp5.prod.vagrant
  admin hostname: admin.ezp5.prod.vagrant
  environment: prod
  username: admin
  password: publish
```

## Customizations

You can define the database, usename, password, location, etc... This is defined on the Vargrantfile from line 56 to 64

```
puppet.facter = {
  "www"               => "/var/www/html",
  "ezpublish_src"     => "http://share.ez.no/content/download/160423/948501/version/5/file/ezpublish5_community_project-2014.07.0-gpl-full.tar.gz",
  "ezpublish_folder"  => "ezpublish5",
  "ezpublish"         => "ezpublish.tar.gz",
  "type"              => "tar", # This can be tar, zip, local (tar format) or git if you're using base_xdedug
  "database_name"     => "ezp", # You can define the database name
  "database_user"     => "ezp", # You can define the database username
  "database_password" => "ezp", # You can define the database password
  "env"               => "prod"  # This can be dev or prod
}
```

## KNOWN LIMITATIONS

When you are running vagrant up, it will appear the following Warnings:

- Warning: Setting manifestdir is deprecated. See http://links.puppetlabs.com/env-settings-deprecations due to https://tickets.puppetlabs.com/browse/PUP-1433

- Warning: The package type's allow_virtual parameter will be changing its default value from false to true in a future release. If you do not want to allow virtual packages, please explicitly set allow_virtual to false. due to https://tickets.puppetlabs.com/browse/PUP-2650

## COPYRIGHT
Copyright (C) 1999-2014 eZ Systems AS. All rights reserved.

## LICENSE
http://www.gnu.org/licenses/gpl-2.0.txt GNU General Public License v2
