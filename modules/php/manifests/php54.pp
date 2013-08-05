class php::php54
{
    exec {
        'add-repo':
            command => 'add-apt-repository ppa:ondrej/php5 -y; apt-get update',
            creates => '/etc/apt/sources.list.d/ondrej-php5-precise.list',
            require => Package['python-software-properties'];


        'add-systemd-repo':
            command => "add-apt-repository -y ppa:ondrej/systemd; apt-get update",
            creates => '/etc/apt/sources.list.d/ondrej-systemd-precise.list',
            require => Package['python-software-properties'],
    }


    file {
        '/etc/apt/sources.list.d':
            mode    => '0755',
            ensure  => 'directory';
    }
}


