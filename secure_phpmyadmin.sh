#!/bin/bash

apt update

export DEBIAN_FRONTEND=noninteractive

   apt install phpmyadmin -y

   ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf

   a2enconf phpmyadmin.conf

  systemctl reload apache2

  sed -i '8iAllowOverride All' /etc/phpmyadmin/apache.conf
  systemctl restart apache2

 
  touch /usr/share/phpmyadmin/.htaccess
  
cat << 'EOF'  > /usr/share/phpmyadmin/.htaccess

AuthType Basic
AuthName "Restricted Files"
AuthUserFile /etc/phpmyadmin/.htpasswd
Require valid-user

EOF

echo -n "Provide User Name for secure phpmyadmin login:"
read username;

echo -n "Provide Password for secure phpmyadmin login:"
read password;

echo "$password" | htpasswd -c -i /etc/phpmyadmin/.htpasswd $username
