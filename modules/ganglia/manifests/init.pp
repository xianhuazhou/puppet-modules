class ganglia {
  $tmppath = "/tmp"
  $gangliahome = "/usr/local/ganglia"

  file {"ganglia":
    path => "${tmppath}/ganglia",
    ensure => file,
    recurse => true, 
    source => "puppet:///modules/ganglia/ganglia"
  }

  exec {"install-ganglia":
    user => "root",
    group => "root",
    cwd => "${tmppath}/ganglia",
    command => "/bin/sh configure --prefix=${gangliahome} --with-gmetad --with-librrd=/usr/local/rrdtool && make && make install && make clean",
    require => File['ganglia'],
    unless => "test `ls ${gangliahome}/sbin/gmond`"
  }

  group {"ganglia":
    name => "ganglia",
    gid => 1200 
  }

  user {"ganglia":
    name => "ganglia",
    gid => 1200,
    system => true,
    require => Group["ganglia"]
  }

  file {"gmond.conf":
    path => "${gangliahome}/etc/gmond.conf",
    content => template("ganglia/gmond.conf.erb"),
    recurse => true,
    require => [User["ganglia"], Exec["install-ganglia"]]
  }

  file {"gmond.init":
    owner => "root",
    group => "root",
    path => "/etc/init.d/gmond",
    source => "puppet:///modules/ganglia/gmond.init"
  }

  service {"gmond":
    name => "gmond",
    enable => true,
    ensure => true,
    require => [Exec["install-ganglia"], File["gmond.init"]]
  }
}
