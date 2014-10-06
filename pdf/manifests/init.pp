class pdf {
  package {
    ['evince','pdfmod','pdftk']:
      ensure => installed;
  }
}
