class anthillpro::agent (
  $remote_host,
  $agent_root   = '/opt/anthill',
  $ant_home     = 'opt/apache-ant-1.7.1',
  $applications = 'none',
  $deploy_root  = '/var/anthill/deploy',
  $java_home    = '/usr/java/latest',
  $log_root     = '/var/log/anthill',
  $remote_port  = '7915',
  $tarball      = 'Anthill Agent Installation 3.7.3.tar.gz',
  $var_root     = '/var/anthill',
) {
  class { 'anthillpro::agent::install':
    agent_root   => $agent_root,
    ant_home     => $ant_home,
    applications => $applications,
    deploy_root  => $deploy_root,
    java_home    => $java_home,
    log_root     => $log_root,
    remote_host  => $remote_host,
    remote_port  => $remote_port,
    tarball      => $tarball,
    var_root     => $var_root,
  }
  include anthillpro::agent::service
}
