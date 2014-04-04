include_recipe "apt"

# packages
package 'curl'

# Add repositories
apt_repository "php55" do
  uri "http://ppa.launchpad.net/ondrej/php5/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "E5267A6C"
end

apt_repository 'apache2' do
  uri 'http://ppa.launchpad.net/ondrej/apache2/ubuntu'
  distribution node['lsb']['codename']
  components ['main']
  keyserver 'keyserver.ubuntu.com'
  key 'E5267A6C'
end

# Install Apache & PHP
include_recipe "openssl"
include_recipe "apache2"
apache_module "authz_default" do
  enable false
end

include_recipe "php"

# Install Composer
bash "composer" do
  code <<-EOH
    curl -s https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
  EOH
end
