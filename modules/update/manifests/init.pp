class update {
  file {"/etc/apt/sources.list":
    content => template("update/source.list.erb"),
    ensure => file,
    replace => true
  }

  $allpackages = [
    'libevent-dev', 
    'libssl-dev', 
    'libgd2-xpm-dev', 
    'libzzip-dev', 
    'libbz2-dev', 
    'libpcre3-dev', 
    'libpcre++-dev', 
    'libxml2-dev', 
    'libmcrypt-dev', 
    'libreadline-dev', 
    'libc-client2007e-dev', 
    'libdb-dev', 
    'libdb4.8-dev', 
    'libcurl4-openssl-dev', 
    'libxslt1-dev', 
    'libt1-dev', 
    'libaio1', 
    'libapr1-dev',
    'libconfuse-dev',
    'ssh', 
    'autoconf', 
    'cmake',
    'make', 
    'libtool', 
    'gcc', 
    'g++', 
    'curl', 
    'bzip2', 
    'unrar', 
    'nmap', 
    'tree', 
    'vim',
    'shorewall', 
    'smbclient', 
    'samba-common', 
    'nfs-common', 
    'expect', 
    'realpath', 
    'libyaml-dev', 
    'bison'
  ]
  package {$allpackages:
    ensure => present,
    require => File['/etc/apt/sources.list']
  } 

  cron {systemupdate:
    command => "apt-get update && apt-get dist-upgrade -y",
    user => root,
    require => File['/etc/apt/sources.list'],
    hour => [1]
  }
}
