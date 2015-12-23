class sshdconfig(
        $config_template = "${module_name}/sshd_config.erb",
    ) {
  
    $service_name = $::osfamily ? {
        /Debian/ => 'ssh',
        /RedHat/ => 'sshd',
        default  => fail("Unsupported osfamily (${::osfamily})"),
    }
    file { '/etc/ssh/sshd_config' :
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template("$config_template"),
        notify  => Service[$service_name],
    }

    service { $service_name:
        ensure => 'running',
        enable => 'true',
    }
}
