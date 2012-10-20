class anthillpro_agent::service {
  service { 'anthill':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['anthillpro_agent::config'],
  }
}
