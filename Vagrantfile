# -*- mode: ruby -*-
# vi: set ft=ruby :

require "yaml"
y = YAML.load File.open ".chef/rackspace_secrets.yaml"

Vagrant.configure("2") do |config|

  config.butcher.knife_config_file = '.chef/knife.rb'

  1.times do |num|
    
    config.vm.define :"git_data_viewer_theodi_org_#{num}" do |config|
      config.vm.box      = "dummy"
      config.vm.hostname = "git-data-viewer-#{num}"

      config.ssh.private_key_path = "./.chef/id_rsa"
      config.ssh.username         = "root"

      config.vm.provider :rackspace do |rs|
        rs.username        = y["username"]
        rs.api_key         = y["api_key"]
        rs.flavor          = /512MB/
        rs.image           = /Precise/
        rs.public_key_path = "./.chef/id_rsa.pub"
        rs.endpoint        = "https://lon.servers.api.rackspacecloud.com/v2"
        rs.auth_url        = "lon.identity.api.rackspacecloud.com"
      end

      config.vm.provision :shell, :inline => "curl -L https://www.opscode.com/chef/install.sh | bash"

      config.vm.provision :chef_client do |chef|
        chef.node_name              = "git-data-viewer-#{num}"
        chef.environment            = "production"
        chef.chef_server_url        = "https://chef.theodi.org"
        chef.validation_client_name = "chef-validator"
        chef.validation_key_path    = ".chef/chef-validator.pem"
        chef.run_list               = chef.run_list = [
            "role[git-data-viewer]"
        ]
      end
    end
        
  end

end
