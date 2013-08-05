Exec {
    path => ['/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/', '/usr/local/bin']
}

File {
    owner  => 'root',
    group  => 'root',
}

class devbox {

    group { "puppet":
        ensure => "present",
    }

    $tools  = ['build-essential','curl', 'locate', 'pastebinit', 'unzip', 'git', 'python-software-properties']

    exec {
        'update-apt':
            command     => 'apt-get update',
            notify      => Exec['upgrade-apt'],
            onlyif => "/bin/bash -c 'exit $(( $(( $(date +%s) - $(stat -c %Y /var/lib/apt/lists/$( ls /var/lib/apt/lists/ -tr1|tail -1 )) )) <= 604800 ))'";

        'upgrade-apt':
            command     => 'apt-get upgrade -y -q -o Dpkg::Options::=--force-confold --force-yes',
            require     => Exec['update-apt'],
            refreshonly => true;
    }

    package { $tools:
        ensure => "installed",
        require => Exec['update-apt'];
    }
}

include devbox
include apache
include php
include mysql
