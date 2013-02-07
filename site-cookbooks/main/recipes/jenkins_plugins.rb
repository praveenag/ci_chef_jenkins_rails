directory "#{node["jenkins"]["home"]}/plugins" do
  owner "jenkins"
end

jenkins_plugin = Proc.new do |resource, plugin, url|
  resource.command "curl -Lsf #{url} -o #{node["jenkins"]["home"]}/plugins/#{plugin}.hpi"
  resource.not_if { File.exists?("#{node["jenkins"]["home"]}/plugins/#{plugin}.hpi") }
  resource.user "jenkins"
  resource.notifies :restart, "service[jenkins]"
end

node["jenkins"]["plugins"].each do |plugin|
  execute "download #{plugin} plugin" do
    jenkins_plugin.call(self, plugin, "http://mirrors.jenkins-ci.org/plugins/#{plugin}/latest/#{plugin}.hpi")
  end
end
