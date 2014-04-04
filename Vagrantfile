# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Configurazione Macchina
IP_ADDRESS = "192.168.33.10"
PROJECT_NAME = "softplace"
DATABASE_PASSWORD = "biella"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Enable Berkshelf support
  config.berkshelf.enabled = true

  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise32"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: IP_ADDRESS

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "www", "/var/www"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # Make sure that the newest version of Chef have been installed
  config.vm.provision :shell, :inline => "apt-get update -qq && apt-get install make ruby1.9.1-dev --no-upgrade --yes"
  config.vm.provision :shell, :inline => "gem install chef --version 11.6.0 --no-rdoc --no-ri --conservative"

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  config.vm.provision :chef_solo do |chef|
    chef.add_recipe "postfix"
    chef.add_recipe "softplace-misc::database"
    chef.add_recipe "softplace-misc::php"
    chef.json = {
      :softplace => {
          # Project name
          :name           => PROJECT_NAME,

          # Name of MySQL database that should be created
          :db_name        => PROJECT_NAME,
      },
      :apache => {
          :default_modules         => %w{ status alias auth_basic authn_file autoindex dir env mime negotiation setenvif rewrite ssl },
          :docroot_dir => '/var/www'
      },
      :php => {
          # Customize PHP modules here
          :packages                => %w{ php5 php5-dev php5-cli php-pear php5-apcu php5-mysql php5-curl php5-mcrypt php5-memcached php5-gd php5-json },

          # It is necessary to specify a custom conf dir as we are using Apache 2.4
          :ext_conf_dir            => "/etc/php5/mods-available"
      },
      :phpunit => {
          :install_method          => 'composer'
      },
      :mysql => {
          # Feel free to change the password to something more secure
          :server_root_password    => DATABASE_PASSWORD,
          :server_repl_password    => DATABASE_PASSWORD,
          :server_debian_password  => DATABASE_PASSWORD,
          :bind_address            => IP_ADDRESS,
          :allow_remote_root       => true
      },
    }
  end
end
