# bash_env_setup
quick puppet module to setup my environment

# Installation:
  - puppet agent atleast needs to be installed
  - puppet module install vcsrepo
  - copy the repo to your module path
    - generally located: .puppetlabs/etc/code/modules/
    - you can get this info by running "puppet config print modulepath" and sourcing it to one of the locations

  - I put the include in the "init.pp" if you plan to run this via puppetserver you will need to rip that off. this was written quickly to deploy my configuration so it isnt fully completed. However the future may change what this looks like.

  - Example of run:
```
feithj@centppm01:/home/feithj/.puppetlabs/etc/code/modules/bash_env_setup/manifests #puppet apply init.pp
Notice: Compiled catalog for centppm01 in environment production in 0.11 seconds
Notice: /Stage[main]/Bash_env_setup/File[/home/feithj/sourcecode]/ensure: created
Error: Execution of '/usr/bin/git submodule update --init --recursive' returned 1: No submodule mapping found in .gitmodules for path 'bundle/ScrollColors'
Error: /Stage[main]/Bash_env_setup/Vcsrepo[/home/feithj/sourcecode/vim]/ensure: change from 'absent' to 'present' failed: Execution of '/usr/bin/git submodule update --init --recursive' returned 1: No submodule mapping found in .gitmodules for path 'bundle/ScrollColors'
Notice: /Stage[main]/Bash_env_setup/File[/home/feithj/vimrc]/ensure: defined content as '{md5}21ecf39459b10e3640834a238df6bbfc'
Notice: /Stage[main]/Bash_env_setup/File[/home/feithj/bashrc]/content: content changed '{md5}f31e8eab1178af04b1175edce50c4eb3' to '{md5}4e9040c5c19ac8ffe99bb26d00423b9f'
Notice: /Stage[main]/Bash_env_setup/File[/home/feithj/bashrc]/mode: mode changed '0644' to '0740'
Notice: /Stage[main]/Bash_env_setup/File[/home/feithj/bashrc.puppet]/ensure: defined content as '{md5}12976b66ab198ca0292c7120b51423b2'
Notice: /Stage[main]/Bash_env_setup/File[/home/feithj/aliases]/ensure: defined content as '{md5}3d343755df43bc40a7ae11cb7a0a33e0'
Notice: Applied catalog in 1.18 seconds
```





