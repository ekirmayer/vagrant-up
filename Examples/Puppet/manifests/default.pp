exec {"apt-get update":
        command => "/usr/bin/apt-get update",
}

package {
  "apache2":
  require => Exec["apt-get update"],
}

file {
  "/var/www":
  ensure => link,
  target =>  "/vagrant",
  force => "true",
  require => Package["apache2"]
}

# host entry with multiple aliases
host { 'dashboard':
  ip           => '10.120.100.111',
  host_aliases => [ 'nagios', 'munin' ],
}
