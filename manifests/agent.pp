class anthillpro::agent (
  $remote_host = '10.5.1.109',
  $tarball     = 'Anthill Agent Installation 3.7.3.tar.gz',
  $use_hiera   = true
) {
  if $use_hiera {
    $agent = hiera('anthillpro::agent')
    class { 'anthillpro::agent::config':
      remote_host => $agent['remote_host'] ? {
        undef   => $remote_host,
        default => $agent['remote_host']
      },
      tarball => $agent['tarball'] ? {
        undef   => $remote_host,
        default => $agent['tarball']
      },
    }
  }
  else {
    class { 'anthillpro::agent::config':
      remote_host => $remote_host,
      tarball     => $tarball,
    }
  }
  include anthillpro::agent::install
  include anthillpro::agent::service
}
