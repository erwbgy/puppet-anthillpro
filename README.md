# _Unmaintained_

I no longer use Puppet actively and this software has not been maintained for some time.

# puppet-anthillpro

Install and provide basic configuration for an Anthill Pro agent.

## Usage

Include the anthillpro module in your puppet configuration:

    include anthillpro

and add required hiera configuration - for example:

    anthillpro::agent::ant_home:     'opt/apache-ant-1.7.1'
    anthillpro::agent::remote_host:  '10.0.17.9'
    anthillpro::agent::tarball:      'Anthill Agent Installation 3.7.3.tar.gz'

or with all the options:

    anthillpro::agent::agent_root:   '/opt/anthill'
    anthillpro::agent::ant_home:     '/usr'
    anthillpro::agent::applications: 'none'
    anthillpro::agent::deploy_root:  '/var/anthill/deploy'
    anthillpro::agent::java_home:    '/usr/java/latest'
    anthillpro::agent::log_root:     '/var/log/anthill'
    anthillpro::agent::remote_host:  '10.5.1.109'
    anthillpro::agent::remote_port:  '7915'
    anthillpro::agent::tarball:      'Anthill Agent Installation 3.7.3.tar.gz'
    anthillpro::agent::var_root:     '/var/anthill'

* *agent_root*: The root directory of the agent installation. Default: '/opt/anthill'

* *ant_home*: The root directory of the Apache Ant installation to use.  Default: 'opt/apache-ant-1.7.1' (relative to the unpacked installation tarball)

* *applications*: Default: 'none'

* *deploy_root*: The root directory under which application deployment artefacts are stored. Default: '/var/anthill/deploy'

* *java_home*: The root directory of the Java virtual machine to use.  Default: '/usr/java/latest' (and '/usr/java/latest/bin/java' will be used)

* *log_root*: The root directory under which log files will be written. Default: '/var/log/anthill'

* *remote_host*:  The hostname/IP of the Anthill server to connect to.  REQUIRED.

* *remote_port*: The port to connect to on the Anthull server. Default: '7915'

* *tarball*: The Anthill Agent installation tarball. Default: 'Anthill Agent Installation 3.7.3.tar.gz'

* *var_root*: The root directory under which runtime files are created (eg. caches, temporary files etc).  Default: '/var/anthill'

## TODO

Support installation and setup of the Anthill server.

## Support

License: Apache License, Version 2.0

GitHub URL: https://github.com/erwbgy/puppet-anthillpro

