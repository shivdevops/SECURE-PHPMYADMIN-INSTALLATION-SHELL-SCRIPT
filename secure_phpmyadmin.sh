#!/bin/bash

apt update

export DEBIAN_FRONTEND=noninteractive

    #installing phpmyadmin
   apt install phpmyadmin -y

   ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf

   a2enconf phpmyadmin.conf

  systemctl reload apache2

  sed -i '8iAllowOverride All' /etc/phpmyadmin/apache.conf
  systemctl restart apache2

 # creates the .htaccess file
  touch /usr/share/phpmyadmin/.htaccess
  
  # configure the .htaccess for secure phpmyadmin
cat << 'EOF'  > /usr/share/phpmyadmin/.htaccess

AuthType Basic
AuthName "Restricted Files"
AuthUserFile /etc/phpmyadmin/.htpasswd
Require valid-user

EOF

# reads the user name for secure phpmyadmin login
echo -n "Provide User Name for secure phpmyadmin login:"
read username;

#reads the password for secure phpmyadmin login
echo -n "Provide Password for secure phpmyadmin login:"
read password;

echo "$password" | htpasswd -c -i /etc/phpmyadmin/.htpasswd $username
