class update {
    file {"/etc/apt/sources.list":
        source => "puppet:///modules/update/sources.list",
        ensure => file,
        replace => true
    }

    cron {systemupdate:
        command => "apt-get update && apt-get dist-upgrade -y",
        user => root,
        require => File['/etc/apt/sources.list'],
        hour => [1]
    }
}
