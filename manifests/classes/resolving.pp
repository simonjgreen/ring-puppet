class resolving {
 
$etcresolvconf = "search ring.nlnog.net
nameserver 127.0.0.1
nameserver ::1
"
    file { "/etc/resolv.conf":
        owner   => root,
        group   => root,
        mode    => 644,
        require => Package["unbound"],
        content => $etcresolvconf,
   }

    package { "unbound":
        ensure => latest,
        before  => File["/etc/init.d/unbound"],
    }

    file { "/etc/init/unbound.conf":
        owner   => root,
        group   => root,
        mode    => 644,
        source  => "puppet:///files/etc/init/unbound.conf",
    }

    file { "/etc/init.d/unbound":
        ensure  => absent,
    }

    service { "unbound":
        ensure      => running,
        require     => [ Package["unbound"], File["/etc/init/unbound.conf"] ],
        provider    => upstart,
    }
}
