class apache::params {

    case $::osfamily {
        'RedHat': {
            $user       = 'apache'
            $group      = 'apache'
            $pkg_name   = 'httpd'
            $svc_name   = 'httpd'
            $extensions = 'php'
            $ssl_package= 'mod_ssl'
        }
        'Debian': {
            $user       = 'www-data'
            $group      = 'www-data'
            $pkg_name   = 'apache2'
            $svc_name   = 'apache2'
            $ssl_package= 'apache-ssl'
            $extensions = [
                'apache2-mpm-worker',
                'libapache2-mod-fastcgi'
            ]
        }
        default: {
            fail("unknown osfamily: $::osfamily")
        }
    }
}
