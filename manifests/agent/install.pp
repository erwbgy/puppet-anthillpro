class anthillpro::agent::install (
  $agent_root,
  $applications,
  $cache_root,
  $deploy_root,
  $java_home,
  $log_root,
  $remote_host,
  $remote_port,
  $tarball,
) {
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
  file { "${log_root}/anthillpro::agent.log":
    ensure => link,
    target => "${agent_root}/agents/deployer-0/var/log/ah3agent.out",
  }
  if ! defined(Package['perl']) { package { 'perl': ensure => installed, } }
  if ! defined(Package['tar'])  { package { 'tar':  ensure => installed, } }
  if ! defined(Package['gzip']) { package { 'gzip': ensure => installed, } }
  exec { 'anthill-install':
    command     => '/root/anthillpro::agent/anthill3-install/unattended-install-agent.sh',
    require     => File['agent/anthill3-install/unattended-install-agent.sh'],
    creates     => "${agent_root}/agents/deployer-0",
  }
  file { "${agent_root}/agents/deployer-0/installed.properties":
    ensure  => present,
    mode    => '0444',
    content => template('anthillpro/agent/installed.properties.erb'),
    notify  => Class['anthillpro::agent::service'],
    require => Exec['anthill-install'],
  }
}
