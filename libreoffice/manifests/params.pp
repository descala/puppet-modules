class libreoffice::params {

  # stable / backports / edge
  $source = 'stable'

  case $::osfamily {
    'Debian': {
      case $::lsbdistcodename {
        'wheezy': {
        }
        default: { fail("unsupported release ${::lsbdistcodename}") }
      }
    }
    default: { fail("unsupported platform ${::osfamily}") }
  }
}
