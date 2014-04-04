# database
include_recipe "mysql::server"

# Create database if it doesn't exist
ruby_block "create_#{node['softplace']['name']}_db" do
  block do
    %x[mysql -uroot -p#{node['mysql']['server_root_password']} -e "CREATE DATABASE #{node['softplace']['db_name']};"]
  end
  not_if "mysql -uroot -p#{node['mysql']['server_root_password']} -e \"SHOW DATABASES LIKE '#{node['softplace']['db_name']}'\" | grep #{node['softplace']['db_name']}";
  action :create
end
