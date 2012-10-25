class anthillpro_agent::install {
  package { ['jdk', 'perl', 'tar', 'gzip']:
    ensure => installed,
  }
  exec { 'install':
    command     => '/root/anthillpro_agent/anthill3-install/unattended-install-agent.sh',
    require     => Class['anthillpro_agent::config'],
    creates     => '/opt/anthill/agents/deployer-0',
  }
  file { '/opt/anthill/agents/deployer-0/installed.properties':
    ensure  => present,
    mode    => '0444',
    content => template('anthillpro_agent/installed.properties.erb'),
    notify  => Class['anthillpro_agent::service'],
    require => Exec['install'],
  }
}
