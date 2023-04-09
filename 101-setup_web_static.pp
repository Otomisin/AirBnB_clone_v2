# Update package index
apt::update { 'update':
  before => Class['nginx'],
}

# Install Nginx package
class { 'nginx':
  ensure => installed,
}

# Create directory structure for web_static deployment
file { '/data/web_static':
  ensure => directory,
}
->
file { '/data/web_static/releases':
  ensure => directory,
}
->
file { '/data/web_static/shared':
  ensure => directory,
}
->
file { '/data/web_static/releases/test':
  ensure => directory,
}
->
file { '/data/web_static/current':
  ensure => 'link',
  target => '/data/web_static/releases/test',
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
  owner => 'ubuntu',
  group => 'ubuntu',
  recurse => true,
}

# Create directory structure for default web server
file { '/var/www/html':
  ensure => directory,
}
->
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

# Configure Nginx to serve static files from /data/web_static/current
file { '/etc/nginx/sites-enabled/default':
  ensure  => 'file',
  content => template('my_module/nginx.conf.erb'),
}
->
service { 'nginx':
  ensure => running,
}
