class rrdtool {
  $tmppath = "/root/tmp"

  $allpackages = [
    'libglib2.0-dev', 
    'libpango1.0-dev', 
    'libcairo2-dev'
  ]
  package {$allpackages:
    ensure => present
  }

  file {"rrdtool":
    path => "${tmppath}/rrdtool",
    ensure => file,
    recurse => true, 
    source => "puppet:///modules/rrdtool/rrdtool"
  }

  exec {"install-rrdtool":
    user => "root",
    group => "root",
    cwd => "${tmppath}/rrdtool",
    command => "/bin/sh configure --prefix=/usr/local/rrdtool && make && make install && make clean",
    require => File['rrdtool'],
    unless => "test `ls /usr/local/rrdtool/bin/rrdtool`"
  }
}
