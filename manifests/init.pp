class anthillpro_agent (
  $remote_host = '10.5.1.109',
  $tarball     = 'Anthill Agent Installation 3.7.3.tar.gz',
  $use_hiera   = true
) {
  if $use_hiera {
    $anthillpro_agent = hiera('anthillpro_agent')
    class { 'anthillpro_agent::config':
      remote_host => $anthillpro_agent['remote_host'] ? {
        undef   => $remote_host,
        default => $anthillpro_agent['remote_host']
      },
      remote_host => $anthillpro_agent['tarball'] ? {
        undef   => $remote_host,
        default => $anthillpro_agent['tarball']
      },
    }
  }
  else {
    class { 'anthillpro_agent::config':
      remote_host => $remote_host,
      tarball     => $tarball,
    }
  }
  include anthillpro_agent::install
  include anthillpro_agent::service
}
