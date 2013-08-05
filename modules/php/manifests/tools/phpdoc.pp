class php::tools::phpdoc {
    exec {
        "install-phpdocumentor":
            command => "pear install --alldeps pear.phpdoc.org/phpDocumentor-alpha",
            require => Exec["pear-upgrade"],
            creates => "/usr/bin/phpdoc"
    }
}