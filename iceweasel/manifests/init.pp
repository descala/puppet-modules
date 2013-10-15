class iceweasel inherits iceweasel::params {
  package { "iceweasel":
    ensure  => latest,
    require => [
      File["/etc/apt/sources.list.d/iceweasel.list"],
      Package["pkg-mozilla-archive-keyring"],
      Package["flashplugin-nonfree"]
    ],
    before  => Exec["apt-update"]
  }
  package { "flashplugin-nonfree": 
    ensure  => installed
  }
  package { "pkg-mozilla-archive-keyring": 
    ensure  => installed,
    notify  => Exec["iceweasel-add-archive-key"],
    require => File["/etc/apt/sources.list.d/iceweasel.list"]
  }
  file { "/etc/apt/sources.list.d/iceweasel.list":
    ensure  => present,
    content => template("iceweasel/sources.list.erb"),
    notify  => Exec["apt-update"]
  }
# TODO this is too specific
#  file { "/etc/iceweasel/pref/iceweasel.js":
#    ensure  => present,
#    content => template("iceweasel/pref.js.erb"),
#    require => Package["iceweasel"]
#  }
  exec { "iceweasel-add-archive-key":
    refreshonly => true,
    command     => "/usr/bin/gpg --check-sigs --fingerprint --keyring /etc/apt/trusted.gpg.d/pkg-mozilla-archive-keyring.gpg --keyring /usr/share/keyrings/debian-keyring.gpg pkg-mozilla-maintainers",
    returns     => ["0", "2"]
  }
}
