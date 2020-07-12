# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
    config.vm.box = "centos/8"

    config.vm.define "bdserver" do |server|
      server.vm.network "public_network", :bridge => "wlp3s0", ip: "192.168.0.140"
      server.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = "1"
      end
      server.vm.provision "shell", inline: "/vagrant/mysql_install.sh"
    end

    config.vm.define "dockerserver" do |server|
      server.vm.network "public_network", :bridge => "wlp3s0", ip:"192.168.0.150"
      server.vm.provider "virtualbox" do |vb|
        vb.memory = "4096"
        vb.cpus = "2"
      end
      server.vm.provision "shell", inline: "/vagrant/docker_install.sh"
    end
  end
  
