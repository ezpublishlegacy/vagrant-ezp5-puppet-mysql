# vagrant:ezp5:puppet:mysql

Prototype development machine for eZ Publish 5.x, provisioned with Puppet.

## Stack & utilities:

- CentOS 6.4 x64
- Apache 2.2.15
- MySQL 5.1.69
- PHP 5.3.3
- APC 3.1.9
- Xdebug 2.2.3 or not, this is your choice through Vagrantfile setup
- Composer
- Git or not, this is your choice throught Vagrantfile setup
- eZ Publish 5 Community 2013.11 ( Installed and ready to use or GIT )

## Requirements:

- Vagrant (http://vagrantup.com)
- VirtualBox (https://www.virtualbox.org/) or VMWare (http://www.vmware.com/)

## Getting started:

The following steps will setup a Cent Os 6.4 based VM for development with eZ Publish 2013.11 pre-installed.
There are to possible processes, the first one you'll clone the repository while the second one you'll download it and extract it without needing to have the git tools installed:

### 1. Cloning the repository

- Clone this project to a directory 

```
$ git clone git@github.com:cleverti/vagrant-ezp5-puppet-mysql.git

$ cd vagrant-ezp5-puppet-mysql
```

### 2. Downloading the repository

- Download: https://github.com/cleverti/vagrant-ezp5-puppet-mysql/archive/master.zip
- Extract the file to a desired location
- Open your console and make sure you are inside the extracted folder

```
$ cd vagrant-ezp5-puppet-mysql
```

### Common steps

- Run `$ vagrant up` from the terminal
- Wait (the first time will take a few minutes, as the base box is downloaded, and required packages are installed for the first time), get some coffee.
- Done! `$ vagrant ssh` to SSH into your newly created machine. The MOTD contains details on the database, hostnames, etc.
- By default Xdebug is enabled, if you want to disable it, go to line 64 and change from "dev" to "prod". Don't forget to run `$ vagrant up` after

## Access your site

- Open your browser on http://localhost:8080

## SSH into VM

You'll have to be inside your folder (vagrant-ezp5-puppet-mysql)

```
$ vagrant ssh
```

or

```
$ ssh vagrant@localhost -p2222

Password: vagrant
```

## Shutdown the VM

You'll have to be inside your folder (vagrant-ezp5-puppet-mysql)

```
$ vagrant halt
```

## Rebuild

You'll have to be inside your folder (vagrant-ezp5-puppet-mysql)

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
  hostname: ezp5.dev.vagrant
  admin hostname: admin.ezp5.dev.vagrant
  environment: dev
```

## Customizations

You can define the database, usename, password, location, etc... This is defined on the Vargrantfile from line 56 to 64

## Limitations

- There is an issue with the network and guest aditions, you have to use Vagrant 1.3.4 http://downloads.vagrantup.com/tags/v1.3.4
- VirtualBox 4.2, version 4.3 isn't supported yet

## COPYRIGHT
Copyright (C) 1999-2014 eZ Systems AS. All rights reserved.

## LICENSE
http://www.gnu.org/licenses/gpl-2.0.txt GNU General Public License v2