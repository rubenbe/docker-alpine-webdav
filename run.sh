#!/bin/bash
set -eou pipefail

if [ -v "USERNAME" -a -v "PASSWORD" ]; then
  echo "Configuring user $USERNAME"
  htpasswd -cb /etc/apache2/webdav.password "$USERNAME" "$PASSWORD"
  chown root:apache /etc/apache2/webdav.password
  chmod 640 /etc/apache2/webdav.password
fi

# Alpine 3.4 still uses the old name 'httpd', instead of 'apache2'.
httpd -D FOREGROUND

