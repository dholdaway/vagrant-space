#!/bin/sh
# deploy  Config script
cd /

echo "--------------------------------------------------------"
echo " Quickup Deployment Script v1.0                         "
echo "--------------------------------------------------------"

echo %admin ALL=NOPASSWD: ALL >> /etc/sudoers
echo Defaults env_keep="SSH_AUTH_SOCK" >> /etc/sudoers

sed -ie 's/us\.archive\.ubuntu\.com/mirror\.bit\.edu\.cn/' /etc/apt/sources.list
sed -ie 's/security\.ubuntu\.com/mirror\.bit\.edu\.cn/' /etc/apt/sources.list

aptitude update
# aptitude upgrade -y
aptitude install -y bash curl git patch bzip2 build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev libgdbm-dev ncurses-dev automake libtool bison subversion pkg-config libffi-dev libcurl3-dev imagemagick libmagickwand-dev libpcre3-dev

apt-get update -y
apt-get install -y git-core
apt-get install -y python-software-properties python g++ make
add-apt-repository -y ppa:chris-lea/node.js
apt-get update -y
apt-get install -y apache2 php5 libapache2-mod-php5 php5-mysql php5-curl
apt-get install -y nodejs
apt-get update -y

# "" =
# "" =
live="$3" 



# EXAMPLE
# IP = 127.0.0.1
# ServerName = example.com
# Vhostname = could be anything


#update time zone

#dpkg-reconfigure tzdata

locale-gen en_GB.UTF-8

date

# time 
apt-get install ntp -y
update-rc.d ntp enable

echo " now installing .zsh "

apt-get install zsh -y

curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

cp ~/.zshrc ~/.zshrc_bak

rm ~/.zshrc -y

sed 's/plugins=(git)/plugins=(git debian node nvm npm ruby rvm)/g' ~/.zshrc_bak > ~/.zshrc

# install Node Version Manager
echo "Installing NVM"

#curl https://raw.github.com/creationix/nvm/master/install.sh | sh

#nvm install v0.10

git clone https://github.com/creationix/nvm.git ~/.nvm

source ~/.nvm/nvm.sh

curl -L https://get.rvm.io | bash -s stable --ruby

source /usr/local/rvm/scripts/rvm

rvm reload

# install via gem



clear

VHOST=$(cat <<EOF
<VirtualHost *:80>
    ServerName $3.co.uk:80
    DocumentRoot /var/www/$3

    LogLevel warn
    ErrorLog /var/log/apache2/$3-error.log
    CustomLog /var/log/apache2/$3-access.log combined

    <Directory /var/www/$3>
                Options Indexes FollowSymLinks MultiViews
                AllowOverride All
                Order allow,deny
                allow from all
    </Directory>

</VirtualHost>
EOF
)

echo "${VHOST}" > /etc/apache2/sites-enabled/000-default

chown root:root /var/log/apache2/$3

chown www-data:www-data /etc/apache2/sites-available/$3

a2ensite $3

a2enmod rewrite

# reload Apache2

service apache2 restart



#Firewall
apt-get install ufw -y
# enable the firewall previously installed
ufw enable

# turn on logging
ufw logging on
 
# set log level
ufw logging low
 
# delete all existing rules
ufw status numbered
ufw delete 

# allow ssh port 
ufw allow ssh

# allow http port
ufw allow http
 
# allow https port
ufw allow https

gem install compass

gem install breakpoint

deb http://apt.newrelic.com/debian/ newrelic non-free

wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add -

apt-get update

apt-get install newrelic-sysmond

nrsysmond-config --set license_key=

/etc/init.d/newrelic-sysmond start

#install Grunt

npm install -g grunt-cli

mkdir /versions
cd /versions
echo "Whats been installed?" >> installed_versions.txt
$1 $2 >> installed_versions.txt
echo _ >> installed_versions.txt
echo _ >> installed_versions.txt
echo "Grunt" >> installed_versions.txt
grunt --version >> installed_versions.txt
echo _ >> installed_versions.txt
echo "Ruby" >> installed_versions.txt
ruby -v >> installed_versions.txt
echo _ >> installed_versions.txt
echo _ >> installed_versions.txt
echo "Compass" >> installed_versions.txt
compass -v >> installed_versions.txt
echo _ >> installed_versions.txt
echo _ >> installed_versions.txt
echo "NPM" >> installed_versions.txt
npm -v >> installed_versions.txt
echo _ >> installed_versions.txt
echo _ >> installed_versions.txt
echo "PHP" >> installed_versions.txt
php -v >> installed_versions.txt
echo _ >> installed_versions.txt
nodejs -v >> installed_versions.txt

apt-get clean

echo "Adding Host names"

echo "ServerName localhost" >> /etc/apache2/httpd.conf 

reboot
