# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.network :forwarded_port, guest: 443, host: 6662
  config.vm.network :private_network, ip: "192.168.50.4"
  
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["./cookbooks", "site-cookbooks"]
    # http://jbbarth.com/posts/2011-03-20-vagrant-provisioning-with-chefsolo.html
    json = JSON.parse(File.read("./nodes/main.json"))

    json["run_list"].each { |run| chef.add_recipe(run) }

    chef.cookbooks_path = ["./cookbooks", "site-cookbooks"]
    chef.json.merge!(json)
  end
end
