# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version '>= 1.6.5'

required_plugins = %w(
  vagrant-hostsupdater
  vagrant-omnibus
  vagrant-berkshelf
)

required_plugins.each do |plugin|
  raise "#{plugin} is not installed." unless Vagrant.has_plugin? plugin
end

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "forwarded_port", guest: 80, host: 18080
  config.vm.network "forwarded_port", guest: 3306, host: 13306
  config.vm.network "private_network", ip: "192.168.33.10"

  config.ssh.forward_agent = true

  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--cpus", 2]
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = "./Berksfile"
  config.omnibus.chef_version = "11.10.4"

  config.vm.provision "chef_solo" do |chef|
    chef.custom_config_path = "Vagrantfile.chef"
    chef.cookbooks_path = "./berks-cookbooks"
    chef.add_recipe "git"
    chef.add_recipe "vim"
    chef.add_recipe "php"
    chef.add_recipe "nginx"
    chef.add_recipe "mysql::server"
    chef.json = {
      mysql: {
        server_root_password: "hoge",
        allow_remote_root: true
      },
      nginx: {
        version: '1.6.2'
      } 
    }
  end

end
