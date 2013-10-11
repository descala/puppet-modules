class libreoffice inherits libreoffice::params {

  # libreoffice from wheezy-backports
  file { '/etc/apt/preferences.d/11_libreoffice.pref':
    ensure  => present,
    content => template('libreoffice/11_libreoffice.pref'),
    notify  => Exec['apt-update']
  }

  package { 'libreoffice-gnome':
    ensure  => present,
    require => File['/etc/apt/preferences.d/11_libreoffice.pref']
  }

}
