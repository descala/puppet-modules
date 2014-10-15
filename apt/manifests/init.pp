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
  #file { '/etc/apt/sources.list.d/jessie.list':
  #  ensure  => present,
  #  content => template('apt/jessie.list.erb')
  #}
  file { '/etc/apt/sources.list.d/backports.list':
    ensure  => present,
    content => template('apt/backports.list.erb')
  }
  file { '/etc/apt/sources.list.d/quantum.list':
    ensure  => present,
    content => template('apt/quantum.list.erb')
  }
  file { '/etc/apt/sources.list.d/postgis.list':
    ensure  => present,
    content => template('apt/postgis.list.erb')
  }
  file { '/etc/apt/sources.list.d/owncloud.list':
    ensure  => present,
    content => template('apt/owncloud.list.erb')
  }
  file { '/etc/apt/sources.list.d/virtualbox.list':
    ensure  => present,
    content => template('apt/virtualbox.list.erb')
  }
  exec { 'apt-update':
    refreshonly => true,
    command     => '/usr/bin/apt-get update'
  }
}
