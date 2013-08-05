class apache2::ssl (
    $snakeoil = true
) inherits apache2::params
{
    a2mod {'ssl':
        ensure => present,
        require => Package[$pkg_name],
    }

    if ($snakeoil == true) {
        file { "/etc/apache2/sites-enabled/default-ssl":
            mode   => '0644',
            ensure => link,
            require=> Package[$pkg_name],
            target => '/etc/apache2/sites-available/default-ssl',
            notify => Service[$svc_name];
        }

#        exec { "regenerate-snakeoil-cert":
#            command => "make-ssl-cert generate-default-snakeoil --force-overwrite";
#        }
    }
}
