class anthillpro_agent {
  $anthill_remote_host = '10.5.1.109'
  $install_tarball = 'Anthill Agent Installation 3.7.3.tar.gz'
  $basedir = '/var/lib/puppet/workspace/anthillpro_agent'
  include anthillpro_agent::config,
    anthillpro_agent::install,
    anthillpro_agent::service
}
