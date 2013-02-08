# jenkins install
include_recipe "main::jenkins"

# postgresql install with trust access for all
node['postgresql']['pg_hba'].each do |x|
  x[:method] = "trust"
end
include_recipe "postgresql::server"
include_recipe "postgresql::client"

# nginx for ssl and basic auth
include_recipe "nginx"

# nodejs for rails asset compiling
include_recipe "nodejs"

# just in case you want some sqlite
include_recipe "sqlite"
package "libsqlite3-dev"

# build a self signed ssl cert
include_recipe "main::ssl_certificate"

# set up the user rvm install
node.set['rvm']['user_installs'] = [
  {
    :user => 'jenkins',
    :home => "/var/lib/jenkins",
    :install_rubies => false,
    :rubies => [ '1.9.3' ]
  }
]
node.set['rvm']['user_install_rubies'] = "false"

# run the rvm install for the user
include_recipe "rvm::user"

# now install jenkins plugs including rvm (see nodes/main)
include_recipe "main::jenkins_plugins"

# *******************************
# nginx app directories
%w(public logs).each do |dir|
  directory "#{node.app.web_dir}/#{dir}" do
    owner node.user.name
    mode "0755"
    recursive true
  end
end

# *******************************
# nginx site config
template "#{node.nginx.dir}/sites-available/#{node.app.name}.conf" do
  source "nginx.conf.erb"
  mode "0644"
end

nginx_site "#{node.app.name}.conf"

# *******************************
# basic auth
template "/etc/nginx/htpasswd" do
  source "nginx.htaccess.erb"
  mode 0644
end

# *******************************
# restart nginx to apply changes
service "nginx" do
  action :restart
end

# *******************************
# add jenkins to postgres
execute "usermod jenkins -aG postgres" do
  not_if "groups jenkins | grep postgres"
end

execute "createuser jenkins --superuser --no-password" do
  user "postgres"
  group "postgres"
  cwd "/var/lib/postgresql"

  not_if "psql postgres -tAc \"SELECT 1 FROM pg_roles WHERE rolname='jenkins'\" | grep 1",
    :cwd => "/var/lib/postgresql",
    :user => "postgres",
    :group => "postgres"
end

# restart jenkins for good measure
service "jenkins" do
  action :restart
end


# *******************************
# allow on 80, 443, 22 - don't leave jenkins on 8080 exposed
node[:firewall][:rules] << {
  "block jenkins, force through nginx" => {
    "port" => "8080",
    "action" => "deny"
  }
}

node[:firewall][:rules] << {
  "ssh" => {
    "port" => "22"
  }
}

node[:firewall][:rules] << {
  "http" => {
    "port" => "80"
  }
}

node[:firewall][:rules] << {
  "ssl" => {
    "port" => "443"
  }
}

include_recipe "ufw"


