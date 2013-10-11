class libreoffice::suite inherits libreoffice {
  package { 'libreoffice':
    ensure  => latest,
    require => File['/etc/apt/preferences.d/11_libreoffice.pref']
  }
}
