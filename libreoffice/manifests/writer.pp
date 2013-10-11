class libreoffice::writer inherits libreoffice {
  package { 'libreoffice-writer':
    ensure  => installed,
    require => File['/etc/apt/preferences.d/11_libreoffice.pref']
  }
}
