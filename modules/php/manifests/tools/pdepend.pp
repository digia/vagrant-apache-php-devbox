class php::tools::pdepend {
    exec {"install-pdepend":
        command => "pear.pdepend.org/PHP_Depend-beta",
        require => Exec["pear-upgrade"],
        creates => "/usr/bin/pdepend";
    }
}