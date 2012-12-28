class anthillpro::agent::install (
  $agent_root,
  $ant_home,
  $applications,
  $cache_root,
  $deploy_root,
  $java_home,
  $log_root,
  $remote_host,
  $remote_port,
  $tarball,
) {
  if ! defined(Package['perl']) { package { 'perl': ensure => installed, } }
  if ! defined(Package['tar'])  { package { 'tar':  ensure => installed, } }
  if ! defined(Package['gzip']) { package { 'gzip': ensure => installed, } }
  if ! defined(Package['bash']) { package { 'bash': ensure => installed, } }
  # defaults
  File {
    owner => 'root',
    group => 'root',
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
    content => template('anthillpro/agent/unattended-install-agent.sh.erb'),
    require => Exec['anthillpro::agent-unpack'],
  }
  exec { 'anthillpro::agent-directories':
    command     => "/bin/mkdir -p '${agent_root}' '${cache_root}' '${deploy_root}' '${log_root}'"
    refreshonly => true,
  }
  file { "${log_root}/anthillpro::agent.log":
    ensure => link,
    target => "${agent_root}/agents/deployer/var/log/ah3agent.out",
  }
  exec { 'anthillpro::agent-install':
    command     => '/root/anthillpro::agent/anthill3-install/unattended-install-agent.sh',
    require     => File['agent/anthill3-install/unattended-install-agent.sh'],
    creates     => "${agent_root}/agents/deployer",
    require     => Exec['anthillpro::agent-directories'],
  }
  file { "${agent_root}/agents/deployer/conf/agent/installed.properties":
    ensure  => present,
    mode    => '0444',
    content => template('anthillpro/agent/installed.properties.erb'),
    notify  => Class['anthillpro::agent::service'],
    require => Exec['anthillpro::agent-install'],
  }
}
