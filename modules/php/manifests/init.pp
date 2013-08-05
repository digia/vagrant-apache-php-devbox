class php(
    $version = '5.4',
    $webserver= 'apache2',
    $xdebug  = true,
    $zoplus  = false,
    $tools = true,
) inherits php::params {

    Class['php']->Class[$webserver]

    if ($version == '5.4') {
        include php::php54
        Class['php::php54']->Class['php']
    }

    if ($tools == true) {
        include php::tools
        Class['php']->Class['php::tools']

    }

    $cfg_path = $version ? {
        '5.3' => '/usr/lib/php5/20090626+lfs',
        '5.4' => '/usr/lib/php5/20100525+lfs',
    }


    package {
        $pkg_name:
            ensure  => "latest",
            require => [
                Exec['update-apt'],
                Package['build-essential']
            ];

        $svc_name:
            require => Package[$pkg_name];

        $php_exts:
            ensure => "latest",
            require => Package[$svc_name];
    }


    service {
        $svc_name:
            enable => true,
            ensure => running,
            require=> Package[$pkg_name],
    }


    exec { "fpm-socket":
            command => "sed -i 's~listen = 127.0.0.1:9000~listen = /var/run/php5-fpm.sock~g' /etc/php5/fpm/pool.d/www.conf",
            require => Package[$svc_name],
            unless  => 'grep -R "listen = /var/run/php5-fpm.sock" "/etc/php5/fpm/pool.d/www.conf"',
            notify  => Service[$svc_name];
    }


    if ($xdebug == true) {

        exec {
            'install-xdebug':
                command => 'pecl uninstall xdebug;pecl install xdebug',
                creates => "$cfg_path/xdebug.so",
                require => Package['php-pear', 'php5-dev'];

            'prepand-extension':
                cwd     => '/etc/php5/conf.d/',
#                command => 'echo -e "zend_extension=$cfg_path/xdebug.so\n" | cat - xdebug.ini > xdebug.ini.tmp && mv xdebug.ini.tmp xdebug.ini',
                command => "sed -i '1i zend_extension=$cfg_path/xdebug.so\n' xdebug.ini",
                notify  => Service[$webserver],
                refreshonly=>true;
        }


        file { '/etc/php5/conf.d/xdebug.ini':
            replace => "no",
            require => Exec['install-xdebug'],
            notify  => Exec['prepand-extension'],
            source  => 'puppet:///modules/php/xdebug.ini';
        }
    }


    if ($zoplus == true) {
        exec {
            "zoplus-extract":
                cwd     => '/usr/src/',
                command => 'tar zxvf ZendOptimizerPlus-7.0.0.tar.gz',
                creates => '/usr/src/ZendOptimizerPlus-7.0.0/',
                notify  => Exec['zoplus-install'],
                require => File['/usr/src/ZendOptimizerPlus-7.0.0.tar.gz'];

            "zoplus-install":
                cwd     => '/usr/src/ZendOptimizerPlus-7.0.0/',
                creates => "$cfg_path/ZendOptimizerPlus.so",
                require => Package[ 'php5-dev', 'build-essential' ],
                command => 'phpize',
                refreshonly=>true,
                notify => Exec['zoplus-configure'];

           'zoplus-configure':
                cwd     => '/usr/src/ZendOptimizerPlus-7.0.0/',
                command => 'sh configure',
                notify  => Exec['zoplus-make'],
                refreshonly => true;

           'zoplus-make':
                cwd     => '/usr/src/ZendOptimizerPlus-7.0.0/',
                command => 'make',
                notify  => Exec['zoplus-maketest'],
                refreshonly => true;

           'zoplus-maketest':
                cwd     => '/usr/src/ZendOptimizerPlus-7.0.0/',
                command => 'make test',
                notify  => Exec['zoplus-makeinstall'],
                refreshonly => true;

           'zoplus-makeinstall':
                cwd     => '/usr/src/ZendOptimizerPlus-7.0.0/',
                command => 'make install',
                notify  => Exec['zoplus-cleanup'],
                refreshonly => true;

            "zoplus-cleanup":
                cwd     => '/usr/src/',
                command => 'rm -rf ZendOptimizerPlus*',
                refreshonly => true;
        }

        file {
            '/usr/src/ZendOptimizerPlus-7.0.0.tar.gz':
                mode   => '0744',
                ensure => present,
                source => 'puppet:///modules/php/ZendOptimizerPlus-7.0.0.tar.gz';

            '/etc/php5/conf.d/zendoptimizerplus.ini':
                mode   => '0644',
                require => Exec['zoplus-install'],
                notify  => Service[$webserver],
                source  => 'puppet:///modules/php/zendoptimizerplus.ini';
        }
    } else {
        file {
            "$cfg_path/ZendOptimizerPlus.so":
                ensure => absent;

            '/etc/php5/conf.d/zendoptimizerplus.ini':
                ensure => absent;
        }
    }

}
