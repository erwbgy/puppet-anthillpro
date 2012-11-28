class anthillpro::agent::install {
  if ! defined(Package['perl']) { package { 'perl': ensure => installed, } }
  if ! defined(Package['tar'])  { package { 'tar':  ensure => installed, } }
  if ! defined(Package['gzip']) { package { 'gzip': ensure => installed, } }
  exec { 'anthill-install':
    command     => '/root/anthillpro::agent/anthill3-install/unattended-install-agent.sh',
    require     => Class['anthillpro::agent::config'],
    creates     => '/opt/anthill/agents/deployer-0',
  }
  file { '/opt/anthill/agents/deployer-0/installed.properties':
    ensure  => present,
    mode    => '0444',
    content => template('anthillpro::agent/installed.properties.erb'),
    notify  => Class['anthillpro::agent::service'],
    require => Exec['anthill-install'],
  }
}
