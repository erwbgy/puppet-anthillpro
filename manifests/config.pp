class anthillpro_agent::config {
  # defaults
  File {
    owner => 'puppet',
    group => 'puppet',
  }
  file { "$anthillpro_agent::basedir":
    ensure => directory,
  }
  file { 'anthillpro_agent-tarball':
    ensure  => present,
    path    => "$anthillpro_agent::basedir/$anthillpro_agent::install_tarball",
    mode    => '0444',
    source  => "puppet:///files/$anthillpro_agent::install_tarball",
    require => File["$anthillpro_agent::basedir"],
  }
  exec { 'anthillpro_agent-unpack':
    command     => "/bin/tar -C $anthillpro_agent::basedir -zxf '$anthillpro_agent::basedir/$anthillpro_agent::install_tarball'",
    require     => File['anthillpro_agent-tarball'],
    creates     => "$anthillpro_agent::basedir/anthill3-install",
  }
  file { "$anthillpro_agent::basedir/anthill3-install/unattended-install-agent.sh":
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
