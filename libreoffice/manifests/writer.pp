class libreoffice::writer inherits libreoffice {
  case $::source {
    'stable': {
      package { 'libreoffice-writer':
        ensure  => installed
      }
    }
    'backports': {
      package { 'libreoffice-writer':
        ensure  => installed,
        require => File['/etc/apt/preferences.d/11_libreoffice.pref']
      }
    }
    'edge': {
      package { 'libreoffice-writer':
        ensure  => absent
      }
    }
    default: {}
  }
}
