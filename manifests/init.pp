
# This will require some other modules be installed
#
# stdlib, vcsrepo
# puppet module install puppetlabs-vcsrepo
# puppet module install puppetlabs-stdlib

class bash_env_setup {

$home = "/home"
$userenv = "feithj"
$envpath = "${home}/${userenv}"
$delivery = 'puppet:///modules/bash_env_setup'

$sc = "sourcecode"

  file { "${envpath}/${sc}":
    ensure => 'directory',
    path   => "${home}/${sc}",
    owner  => "${userenv}",
    group  => "${userenv}",
    mode   => '0744',
  }

# pulling .vim directory structure to sourcecode directory
  vcsrepo { "${envpath}/${sc}/vim":
    ensure   => present,
    provider => git,
    source   => 'https://github.com/feithj/vim.git',
    submodules => true,
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
    owner  => "${userenv}",
    group  => "${userenv}",
    mode   => '0740',
  }

  file { "${envpath}/bashrc":
    ensure => 'present',
    path   => "${envpath}/.bashrc",
    source => "${delivery}/bashrc",
    owner  => "${userenv}",
    group  => "${userenv}",
    mode   => '0740',
  }

  file { "${envpath}/bashrc.puppet":
    ensure => 'present',
    path   => "${envpath}/.bashrc.puppet",
    source => "${delivery}/bashrc.puppet",
    owner  => "${userenv}",
    group  => "${userenv}",
    mode   => '0740',
  }

  file { "${envpath}/aliases":
    ensure => 'present',
    path   => "${envpath}/.aliases",
    source => "${delivery}/aliases",
    owner  => "${userenv}",
    group  => "${userenv}",
    mode   => '0740',
  }

  file { "${envpath}/.vim":
    ensure => 'link',
    target => "${envpath}/${sc}/vim",
  }

}

include bash_env_setup
