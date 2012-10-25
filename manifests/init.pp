class anthillpro_agent (
  $remote_host = '10.5.1.109',
  $tarball     = 'Anthill Agent Installation 3.7.3.tar.gz'
) {
  class { 'anthillpro_agent::config':
    remote_host => $remote_host,
    tarball     => $tarball,
  }
  include anthillpro_agent::install
  include anthillpro_agent::service
}
