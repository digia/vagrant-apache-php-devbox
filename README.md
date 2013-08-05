
     _|_|_|                          _|
     _|    _|    _|_|    _|      _|  _|_|_|      _|_|    _|    _|
     _|    _|  _|_|_|_|  _|      _|  _|    _|  _|    _|    _|_|
     _|    _|  _|          _|  _|    _|    _|  _|    _|  _|    _|
     _|_|_|      _|_|_|      _|      _|_|_|      _|_|    _|    _|

    git clone https://github.com/sstutz/devbox-vagrant
    cd ./devbox-vagrant
    vagrant up

# Devbox's Vagrant setup

A simple Vagrant setup with Ubuntu 12.04 LTS for developing PHP applications.

## Requirements
To make use of this setup some additional software is required.

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads) - A powerful x86 and AMD64/Intel64 virtualization software package.
* [Vagrant](http://www.vagrantup.com/) (1.1+) - A tool for building complete development environments.
* [git](http://git-scm.com/) - A free and open source distributed version control system.

## Inlcuded software

* Apache 2.2
    * SSL
    * SPDY
    * FastCGI
* PHP 5.3 (php-fpm)
    * curl
    * gd
    * intl
    * memcache
    * mysql
    * mcrypt
    * imagick
    * pear
* PHP Quality Assurance
    * PHPUnit
    * PHPLOC
    * PHP Mess Detector
    * PHP Copy/Paste Detector
    * PHP_CodeSniffer
    * PHP_CodeBrowser
    * PHP_Depend
* Composer
* phpmyadmin
* MySQL 5.5
* Zend Optimizer+ v.7
* Xdebug 2.2 (remote debugging and profiling enabled on port 9000)
* pastebinit (lets you send STDOUT to pastebin and gives you the URL in return)

## Change Log

### 0.2.0 (2013-04-11)

* Added The PHP Quality Assurance Toolchain, PHP Depend, and PHPDocumentor
* Added mkdir statement to the Vageantfile to auto create the NFS folder.
* Removed htdocs folder out of the repository and added it to the gitognore file

### 0.1.0 (2013-04-08)

* Initial public release