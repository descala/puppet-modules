class apt inherits apt::params {
  package { 'apt':
    ensure  => installed
  }
  package { 'debian-keyring':
    ensure => installed
  }
  file { '/etc/apt/sources.list':
    ensure  => present,
    content => template('apt/sources.list.erb')
  }
  file { '/etc/apt/sources.list.d/jessie.sources.list':
    ensure  => present,
    content => template('apt/jessie.sources.list.erb')
  }
  file { '/etc/apt/backports.sources.list':
    ensure  => present,
    content => template('apt/backports.sources.list.erb')
  }
  file { '/etc/apt/quantum.sources.list':
    ensure  => present,
    content => template('apt/quantum.sources.list.erb')
  }
  file { '/etc/apt/postgis.sources.list':
    ensure  => present,
    content => template('apt/postgis.sources.list.erb')
  }
  file { '/etc/apt/owncloud.sources.list':
    ensure  => present,
    content => template('apt/owncloud.sources.list.erb')
  }
  file { '/etc/apt/virtualbox.sources.list':
    ensure  => present,
    content => template('apt/virtualbox.sources.list.erb')
  }
  exec { 'apt-update':
    refreshonly => true,
    command     => '/usr/bin/apt-get update'
  }
}
