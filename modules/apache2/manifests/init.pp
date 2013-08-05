class apache2 (
    $ssl = true,
    $spdy= true,
) inherits apache2::params {

    package {
        $pkg_name:
            ensure => latest,
            require=> Exec['update-apt'];

        $extensions:
            ensure => latest,
            require=> Package[$pkg_name];
    }


    file {
        '/etc/apache2/conf.d/fqdn':
            mode    => '0644',
            ensure  => present,
            require => Package[$pkg_name],
            content => 'ServerName locahlost';

        '/etc/apache2/conf.d/fastcgi.conf':
            mode    => '0644',
            ensure  => present,
            require => Package[$pkg_name],
            source  => 'puppet:///modules/apache2/fastcgi.conf',
            notify  => Service[$svc_name];

    }


    A2mod {
        require=> Package[$pkg_name],
        notify => Service[$svc_name]
    }


    a2mod {
        'actions': ensure => present;
        'fastcgi': ensure => present;
        'rewrite': ensure => present;
        'expires': ensure => present;
        'alias':   ensure => present;
    }


    service { $svc_name:
        ensure      => running,
        enable      => true,
        require     => Package[$pkg_name],
    }


    if ($ssl == true) {
        include apache2::ssl
    }


    if ($spdy == true) {
        if ($ssl == false) {
            err("SSL has to be enabled in order to use SPDY!")
        } else {
            include apache2::spdy
        }
    }
}
