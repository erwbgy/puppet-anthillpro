class anthillpro_agent::install {
  realize( Package["jdk", "perl", "tar", "gzip"] )
  exec { "install":
    command     => "$anthillpro_agent::basedir/anthill3-install/unattended-install-agent.sh",
    require     => Class["anthillpro_agent::config"],
    creates     => "/opt/anthill/agents/deployer-0",
  }
  file { "/opt/anthill/agents/deployer-0/installed.properties":
    ensure  => present,
    mode    => 444,
    content => template("anthillpro_agent/installed.properties.erb"),
    notify  => Class["anthillpro_agent::service"],
    require => Exec["install"],
  }
}
