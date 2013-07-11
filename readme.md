# vagrant:ezp5:puppet

Prototype development machine for eZ Publish 5.x, provisioned with Puppet.

## Stack & utilities:

- CentOS 6.4 x64
- Apache2
- MySQL
- PHP 5.3.3
- Composer
- eZ Publish 5 Community 2013.6
- Xdebug

## Requirements:

- Vagrant (http://vagrantup.com)
- VirtualBox (https://www.virtualbox.org/) or VMWare (http://www.vmware.com/)

## Getting started:

- Clone this project to a directory
- Run `$ vagrant up` from the terminal
- Wait (the first time will take a few minutes, as the base box is downloaded, and required packages are installed for the first time), get some coffee.
- Done! `$ vagrant ssh` to SSH into your newly created machine. The MOTD contains details on the database, hostnames, etc.
