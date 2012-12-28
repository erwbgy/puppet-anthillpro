# puppet-anthillpro

Install and provide basic configuration for an Anthill Pro agent.

## Usage

Include the anthillpro module in your puppet configuration:

    include anthillpro

and add required hiera configuration - for example:

    anthillpro::agent:
      remote_host: 10.0.17.9
      tarball: 'Anthill Agent Installation 3.7.3.tar.gz'

## TODO

Make lots of things configurable.

Support installation and setup of the Anthill server.

## Support

License: Apache License, Version 2.0

GitHub URL: https://github.com/erwbgy/puppet-anthillpro

