class php::dotdeb
{
    exec { 'dotdeb-key':
        cwd     => '/tmp',
        command => 'wget -O- http://www.dotdeb.org/dotdeb.gpg | sudo apt-key add -',
        require => File['/etc/apt/sources.list.d/dotdeb.list'],
        notify  => Exec['update-apt'];
    }

    file {
        '/etc/apt/sources.list.d':
            mode    => '0755',
            ensure  => 'directory';

        '/etc/apt/sources.list.d/dotdeb.list':
            require=> File['/etc/apt/sources.list.d'],
            source => 'puppet:///modules/php/dotdeb.list';
    }
}
