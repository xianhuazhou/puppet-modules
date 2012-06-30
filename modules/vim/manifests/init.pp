class vim {
  file {"/root/.vimrc":
    source => "puppet:///modules/vim/.vimrc",
    ensure => file,
    require => Package["vim"]
  }

  file {"/root/.vim":
    source => "puppet:///modules/vim/.vim",
    recurse => true, 
    ensure => directory,
    require => Package["vim"]
  }
}
