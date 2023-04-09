# Update package index
exec { 'apt-update':
  command => '/usr/bin/apt-get update',
  path    => ['/usr/bin', '/usr/sbin'],
  before  => Class['nginx'],
}

# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Create directory structure for web_static deployment
file { ['/data/web_static', '/data/web_static/releases', '/data/web_static/shared', '/data/web_static/releases/test']:
  ensure => directory,
}

# Create HTML file for Nginx server test
file { '/data/web_static/releases/test/index.html':
  ensure  => 'file',
  content => "<!DOCTYPE html>
<html>
  <head>
  </head>
  <body>
    <p>Nginx server test</p>
  </body>
</html>",
}

# Change ownership of /data directory to ubuntu user
file { '/data':
  owner   => 'ubuntu',
  group   => 'ubuntu',
  recurse => true,
}

# Create directory structure for default web server
file { '/var/www/html':
  ensure => directory,
}

# Create index.html for default web server
file { '/var/www/html/index.html':
  ensure  => 'file',
  content => "<!DOCTYPE html>
<html>
  <head>
  </head>
  <body>
    <p>Nginx server test</p>
  </body>
</html>",
}

# Configure Nginx to serve static files in /data/web_static/current
file { '/etc/nginx/sites-enabled/default':
  ensure  => 'file',
  content => template('my_module/nginx.conf.erb'),
}

# Create symbolic link to current web_static release
file { '/data/web_static/current':
  ensure => 'link',
  target => '/data/web_static/releases/test',
}

# Ensure Nginx is running
service { 'nginx':
  ensure => running,
}
