class motd {
    file { "/etc/update-motd.d/20-cpu-checker":                                  
        ensure => absent,                                                       
    }

    file { "/etc/update-motd.d/50-landscape-sysinfo":
        ensure => present,
        mode => 0755,
        source => "puppet:///files/etc/update-motd.d/50-landscape-sysinfo",
        require => Package["update-motd"],
    }
}
