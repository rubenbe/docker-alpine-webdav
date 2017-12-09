#!/bin/bash
set -eou pipefail

if [ -v "USERNAME" -a -v "PASSWORD" ]; then
  echo "Configuring user $USERNAME"
  htpasswd -cb /etc/apache2/webdav.password "$USERNAME" "$PASSWORD"
  chown root:apache /etc/apache2/webdav.password
  chmod 640 /etc/apache2/webdav.password
  ln -vs /etc/apache2/conf.disabled/dav.auth.conf /etc/apache2/conf.d/
else
  ln -vs /etc/apache2/conf.disabled/dav.noauth.conf /etc/apache2/conf.d/
fi

# Alpine still uses the old name 'httpd', instead of 'apache2'.
httpd -D FOREGROUND
