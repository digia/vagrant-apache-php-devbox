class mysql (
    $root_password = "root"
) inherits mysql::params {


    package { $pkg_name:
        ensure => latest,
        require=> Exec['update-apt'];
    }


    service { $srv_name:
        ensure  => running,
        enable  => true,
        require => Package[$pkg_name]
    }


    exec { "set-mysql-password":
            unless  => "mysqladmin -uroot -p$root_password status",
            command => "mysqladmin -uroot password $root_password",
            require => Service[$srv_name],
    }
}