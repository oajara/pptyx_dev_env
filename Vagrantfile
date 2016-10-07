# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    config.vm.synced_folder ".", "/vagrant", mount_options: ["dmode=700,fmode=600"]
  else
    config.vm.synced_folder ".", "/vagrant"
  end
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
  end
  config.vm.define :pptyxvm do |dev|
    dev.vm.network "private_network", ip: "10.100.199.180"
    dev.vm.provision :shell, path: "scripts/bootstrap.sh"
    dev.vm.provision :shell,
      inline: 'PYTHONUNBUFFERED=1 ansible-playbook \
        /vagrant/ansible/pptyx-vm.yml -c local'
  end
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end
  config.vm.network "forwarded_port", guest: 3306, host: 13306
  config.vm.network "forwarded_port", guest: 80, host: 10080
end
