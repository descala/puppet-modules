class libreoffice(
  $source = $libreoffice::params::source
) inherits libreoffice::params {

  case $source {
    'edge': {
      #TODO: this uninstalls gnome metapackage...
      #package { 'libreoffice-gnome':
      #  ensure => absent
      #}
      file { '/opt/install_libreoffice.sh':
        ensure  => present,
        mode    => '0700',
        content => template('libreoffice/install_libreoffice.sh.erb')
      }
      exec { 'libreoffice-install':
        creates => '/opt/libreoffice4.2',
        command => '/opt/install_libreoffice.sh',
        require => File['/opt/install_libreoffice.sh'],
        timeout => 900 # 15 min
      }
    }

    'backports': {
      package { 'libreoffice-gnome':
        ensure  => present,
        require => File['/etc/apt/preferences.d/11_libreoffice.pref']
      }
      file { '/etc/apt/preferences.d/11_libreoffice.pref':
        ensure  => present,
        content => template('libreoffice/11_libreoffice.pref'),
        notify  => Exec['apt-update']
      }
      # workaround bug: https://www.libreoffice.org/bugzilla/show_bug.cgi?id=67527
      exec { '/bin/sed -i "s/^X-GIO-NoFuse=true/#X-GIO-NoFuse=true/" /usr/lib/libreoffice/share/xdg/*.desktop':
        onlyif  => '/bin/grep -q "^X-GIO-NoFuse=true" /usr/lib/libreoffice/share/xdg/*.desktop',
        require => Package['libreoffice-gnome'];
      }
      exec { '/bin/sed -i "s/^X-KDE-Protocols=file,http,smb,ftp,webdav/#X-KDE-Protocols=file,http,smb,ftp,webdav/" /usr/lib/libreoffice/share/xdg/*.desktop':
        onlyif  => '/bin/grep -q "^X-KDE-Protocols=file,http,smb,ftp,webdav" /usr/lib/libreoffice/share/xdg/*.desktop',
        require => Package['libreoffice-gnome'];
      }
    }

    default: {
      package { 'libreoffice-gnome':
        ensure  => present,
      }
    }
  }

}
