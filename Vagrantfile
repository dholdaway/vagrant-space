# -*- mode: ruby -*-
# vi: set ft=ruby :
#
require 'vagrant-rackspace'

Vagrant.configure("2") do |config|
#Vagrant::Config.run do |config|
  config.vm.hostname = 'mynode.liveserver'
  config.vm.box = "dummy"
  config.vm.provision :shell, :path => "bootstrap.sh"
  config.ssh.private_key_path = "~/.ssh/id_rsa"
  config.vm.provider :rackspace do |os|
    os.username = "darrenholdaway"
    os.api_key = "cf7da018a049872a5699e944dd0335e3"
    os.flavor = /4GB/
    os.image = /Ubuntu 12.04/ 
    #os.keypair_name = ""
    os.server_name = "liveserver"
    os.public_key_path = "~/.ssh/id_rsa.pub"
   # os.tenant = "TENANTID"
  end
end
