class apache::spdy inherits apache::params {

    case $::architecture {
        'i386': {
            $debfile = "mod-spdy-beta_current_i386.deb"
        }
        'amd64':  {
            $debfile = "mod-spdy-beta_current_amd64.deb"
        }
    }

    exec {
        "download-modspdy":
            cwd => '/tmp/',
            require => Package[$pkg_name],
            creates => '/usr/lib/apache2/modules/mod_spdy.so',
            command => "wget https://dl-ssl.google.com/dl/linux/direct/$debfile",
            notify => Exec['install-modspdy'];


        "install-modspdy":
            command => "dpkg -i /tmp/${debfile}",
            refreshonly => true,
            notify => Service[$svc_name];
    }
}