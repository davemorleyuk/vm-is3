# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
#  config.vm.box = "debian64-6.0.7"
#  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/debian-607-x64-vbox4210.box"
  
#  config.vm.box = "centos64-5.9"
#  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-59-x64-vbox4210.box"  
  
#  config.vm.box = "chef/debian-7.4"
#  config.vm.box = "chef/centos-6.5"
#	config.vm.box = "rosio/centos6-x32-chef"  
#	config.vm.box = "hashicorp/precise64"
	config.vm.box = "mobileoverlord/centos-6.5"
# config.vm.box = "xanagi/centos-6.5-chef"	
  
	config.vm.network :private_network, ip: "192.168.56.3"
  config.vm.network "forwarded_port", guest: 3306, host: 33003
	
#  config.vm.provider :virtualbox do |vb|
#    vb.customize ["modifyvm", :id, "--memory", "1024"]
#  end	
  
  config.vm.synced_folder "../../PROJECTS/is3/app", "/home/vagrant/app"
  config.vm.synced_folder "../../PROJECTS/is3/mysql_scripts", "/home/vagrant/mysql_scripts"

  config.vm.provision :chef_solo do |chef|
    chef.roles_path = "./chef/roles"
    chef.cookbooks_path = ["./chef/site-cookbooks", "./chef/cookbooks"]
    chef.add_role "vagrant-test-box"
  end

end