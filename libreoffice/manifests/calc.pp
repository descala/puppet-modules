class libreoffice::calc inherits libreoffice {
  case $::source {
    'stable': {
      package { 'libreoffice-calc':
        ensure  => installed
      }
    }
    'backports': {
      package { 'libreoffice-calc':
        ensure  => installed,
        require => File['/etc/apt/preferences.d/11_libreoffice.pref']
      }
    }
    'edge': {
      package { 'libreoffice-calc':
        ensure  => absent
      }
    }
    default: {}
  }
}
