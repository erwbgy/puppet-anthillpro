class anthillpro::agent::service {
  service { 'anthill':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['anthillpro::agent::config'],
  }
}
