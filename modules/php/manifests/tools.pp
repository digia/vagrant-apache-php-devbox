class php::tools (
    $qatools = true,
    $phpdoc = true,
    # $composer=true,
    $pdepend=true,
){
    exec {
        "pear-autodiscover":
            command => "pear config-set auto_discover 1",
            require => Package["php-pear"],
            onlyif  => 'test "`pear config-get auto_discover`" = "0"',
            notify  => Exec["pear-upgrade"];

        "pear-upgrade":
            command => "pear update-channels && pear upgrade-all",
            require => Exec["pear-autodiscover"],
            refreshonly=> true;
    }


    if ($qatools == true) {
        include php::tools::qatools
    }


    if ($phpdoc == true) {
        include php::tools::phpdoc
    }


    if ($composer == true) {
        include php::tools::composer
    }


    if ($pdepend == true) {
        include php::tools::pdepend
    }
}
