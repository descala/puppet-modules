class libreoffice::suite inherits libreoffice {
  case $libreoffice::source {
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
      package { ['libreoffice','libreoffice-common']:
        ensure  => absent
      }
    }
    default: {
      fail("unknown value for source variable on libreoffice::suite ($libreoffice::source)")
    }
  }
}
