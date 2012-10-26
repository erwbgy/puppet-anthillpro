class anthillpro_agent::config (
  $remote_host = undef,
  $tarball     = undef
) {
  if $remote_host == undef {
    fail('anthillpro_agent::config remote_host parameter required')
  }
  if $tarball == undef {
    fail('anthillpro_agent::config tarball parameter required')
  }
  # defaults
  File {
    owner => 'puppet',
    group => 'puppet',
  }
  file { '/root/anthillpro_agent':
    ensure => directory,
  }
  file { 'anthillpro_agent-tarball':
    ensure  => present,
    path    => "/root/anthillpro_agent/${tarball}",
    mode    => '0444',
    source  => "puppet:///files/${tarball}",
    require => File['/root/anthillpro_agent'],
  }
  exec { 'anthillpro_agent-unpack':
    command     => "/bin/tar -C /root/anthillpro_agent -zxf '/root/anthillpro_agent/${tarball}'",
    require     => File['anthillpro_agent-tarball'],
    creates     => '/root/anthillpro_agent/anthill3-install',
  }
  file { '/root/anthillpro_agent/anthill3-install/unattended-install-agent.sh':
    ensure  => present,
    mode    => '0555',
    content => template('anthillpro_agent/unattended-install-agent.sh.erb'),
    require => Exec['anthillpro_agent-unpack'],
  }
  file { [ '/opt/sb-apps', '/var/sb-logs', ]:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  file { '/var/log/anthillpro_agent.log':
    ensure => link,
    target => '/opt/anthill/agents/deployer-0/var/log/ah3agent.out',
  }
  # connects to anthill.sportingbet.com (10.5.1.109) on ports: 80, 7915
}
