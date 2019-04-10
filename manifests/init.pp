
# This will require some other modules be installed
#
# stdlib, vcsrepo
# puppet module install puppetlabs-vcsrepo
# puppet module install puppetlabs-stdlib

class bash_env_setup (

$home    = '/home',
$userenv = ['demo1', 'demo2'],

){

# Run it through a for loop
$userenv.each |String $usrname| {

  if "${usrname}" == 'root' {
    notify {'Setting up root profile as well': }
    $envpath = "/${usrname}"
  } else {
    $envpath = "${home}/${usrname}"
  }

  $delivery = 'puppet:///modules/bash_env_setup'

  $sc = 'sourcecode'

    file { "${envpath}/${sc}":
      ensure => 'directory',
      path   => "${envpath}/${sc}",
      owner  => "${usrname}",
      group  => "${usrname}",
      mode   => '0744',
    }

# pulling .vim directory structure to sourcecode directory
    vcsrepo { "${envpath}/${sc}/vim":
      ensure     => present,
      provider   => git,
      source     => 'https://github.com/feithj/vim.git',
      submodules => true,
      user       => "${usrname}"
    }

#  vcsrepo { "${envpath}/${sc}/buildscripts":
#    ensure   => latest,
#    provider => git,
#    source   => 'git@fanlvgit1p.ops.invesco.net:sysadmin/buildscripts.git',
#  }

# Setting up environment variables
    file { "${envpath}/vimrc":
      ensure => 'present',
      path   => "${envpath}/.vimrc",
      source => "${delivery}/vimrc",
      owner  => "${usrname}",
      group  => "${usrname}",
      mode   => '0755',
    }

    file { "${envpath}/bashrc":
      ensure => 'present',
      path   => "${envpath}/.bashrc",
      source => "${delivery}/bashrc",
      owner  => "${usrname}",
      group  => "${usrname}",
      mode   => '0755',
    }

    file { "${envpath}/bashrc.puppet":
      ensure => 'present',
      path   => "${envpath}/.bashrc.puppet",
      source => "${delivery}/bashrc.puppet",
      owner  => "${usrname}",
      group  => "${usrname}",
      mode   => '0755',
    }

    file { "${envpath}/aliases":
      ensure => 'present',
      path   => "${envpath}/.aliases",
      source => "${delivery}/aliases",
      owner  => "${usrname}",
      group  => "${usrname}",
      mode   => '0755',
    }

    file { "${envpath}/.vim":
      ensure => 'link',
      target => "${envpath}/${sc}/vim",
    }
  }                                         # close for loop
}                                           # close class

#include bash_env_setup
