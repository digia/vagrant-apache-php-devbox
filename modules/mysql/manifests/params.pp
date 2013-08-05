class mysql::params {

    case $::osfamily {
        'RedHat': {
            $pkg_name   = ''
            $srv_name   = ''
        }
        'Debian': {
            $pkg_name   = 'mysql-server'
            $srv_name   = 'mysql'
        }
        default: {
            fail("unknown osfamily: $::osfamily")
        }
    }
}