class anthillpro::agent::config (
  $remote_host = undef,
  $tarball     = undef
) {
  if $remote_host == undef {
    fail('anthillpro::agent::config remote_host parameter required')
  }
  if $tarball == undef {
    fail('anthillpro::agent::config tarball parameter required')
  }
  # defaults
  File {
    owner => 'puppet',
    group => 'puppet',
  }
  file { '/root/anthillpro::agent':
    ensure => directory,
  }
  file { 'anthillpro::agent-tarball':
    ensure  => present,
    path    => "/root/anthillpro::agent/${tarball}",
    mode    => '0444',
    source  => "puppet:///files/${tarball}",
    require => File['/root/anthillpro::agent'],
  }
  exec { 'anthillpro::agent-unpack':
    command     => "/bin/tar -C /root/anthillpro::agent -zxf '/root/anthillpro::agent/${tarball}'",
    require     => File['anthillpro::agent-tarball'],
    creates     => '/root/anthillpro::agent/anthill3-install',
  }
  file { '/root/anthillpro::agent/anthill3-install/unattended-install-agent.sh':
    ensure  => present,
    mode    => '0555',
    content => template('anthillpro::agent/unattended-install-agent.sh.erb'),
    require => Exec['anthillpro::agent-unpack'],
  }
  file { [ '/opt/sb-apps', '/var/sb-logs', ]:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  file { '/var/log/anthillpro::agent.log':
    ensure => link,
    target => '/opt/anthill/agents/deployer-0/var/log/ah3agent.out',
  }
}
