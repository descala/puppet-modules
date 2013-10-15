class libreoffice(
  $source = $libreoffice::params::source
) inherits libreoffice::params {

  case $source {
    'edge': {
      package { 'libreoffice-gnome':
        ensure => absent
      }
      file { '/opt/install_libreoffice.sh':
        ensure  => present,
        mode    => '0700',
        content => template('libreoffice/install_libreoffice.sh.erb')
      }
      exec { 'libreoffice-install':
        creates => '/opt/libreoffice4.1',
        command => '/opt/install_libreoffice.sh',
        require => File['/opt/install_libreoffice.sh']
      }
    }

    default: {
      package { 'libreoffice-gnome':
        ensure  => present,
        require => File['/etc/apt/preferences.d/11_libreoffice.pref']
      }
      if $source == 'backports' {
        # libreoffice from wheezy-backports
        file { '/etc/apt/preferences.d/11_libreoffice.pref':
          ensure  => present,
          content => template('libreoffice/11_libreoffice.pref'),
          notify  => Exec['apt-update']
        }
      }
    }
  }

}
