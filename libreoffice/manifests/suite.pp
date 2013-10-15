class libreoffice::suite inherits libreoffice {
  case $::source {
    'stable': {
      package { 'libreoffice':
        ensure  => latest
      }
    }
    'backports': {
      package { 'libreoffice':
        ensure  => latest,
        require => File['/etc/apt/preferences.d/11_libreoffice.pref']
      }
    }
    'edge': {
      package { 'libreoffice':
        ensure  => absent
      }
    }
    default: {}
  }
}
