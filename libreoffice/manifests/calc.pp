class libreoffice::calc inherits libreoffice {
  package { 'libreoffice-calc':
    ensure  => installed,
    require => File['/etc/apt/preferences.d/11_libreoffice.pref']
  }
}
