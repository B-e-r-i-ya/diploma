# -*- mode: ruby -*-
# vim: set ft=ruby :
home = ENV['HOME']
ENV["LC_ALL"] = "en_US.UTF-8"

MACHINES = {
              :pxc1 => {
                    :box_name => "centos/7",
                    #:box_version => "1804.02",
                    :ip_addr => '192.168.50.21',
                    :disks => {
                                :sata1 => {
                                    :dfile => home + '/pxc1/sata1.vdi',
                                    :size => 10240,
                                    :port => 1
                                },
                                
                            }
                        },
              :pxc2 => {
                    :box_name => "centos/7",
                    #:box_version => "1804.02",
                    :ip_addr => '192.168.50.22',
                    :disks => {
                                :sata1 => {
                                    :dfile => home + '/pxc2/sata1.vdi',
                                    :size => 10240,
                                    :port => 1
                                },
                                
                            }
                        },                        
              :pxc3 => {
                    :box_name => "centos/7",
                    #:box_version => "1804.02",
                    :ip_addr => '192.168.50.23',
                    :disks => {
                                :sata1 => {
                                    :dfile => home + '/pxc3/sata1.vdi',
                                    :size => 10240,
                                    :port => 1
                                },
                                
                            }
                        },
               :prxsql1 => {
                    :box_name => "centos/7",
                    #:box_version => "1804.02",
                    :ip_addr => '192.168.50.20',
                    :disks => {
                                :sata1 => {
                                    :dfile => home + '/prxsql1/sata1.vdi',
                                    :size => 10,
                                    :port => 1
                                },
                                
                            }
                        },

            }

Vagrant.configure("2") do |config|

    #config.vm.box_version = "1804.02"
    #config.vm.guest.no_install = true
    MACHINES.each do |boxname, boxconfig|

        config.vm.define boxname do |box|

            box.vm.box = boxconfig[:box_name]
            box.vm.host_name = boxname.to_s

            #box.vm.network "forwarded_port", guest: 3260, host: 3260+offset

            box.vm.network "private_network", ip: boxconfig[:ip_addr]

            box.vm.provider :virtualbox do |vb|
                    vb.customize ["modifyvm", :id, "--memory", "256"]
                    needsController = false
            boxconfig[:disks].each do |dname, dconf|
                unless File.exist?(dconf[:dfile])
                  vb.customize ['createhd', '--filename', dconf[:dfile], '--variant', 'Fixed', '--size', dconf[:size]]
                                  needsController =  true
                            end

            end
                    if needsController == true
                       vb.customize ["storagectl", :id, "--name", "SATA", "--add", "sata" ]
                       boxconfig[:disks].each do |dname, dconf|
                           vb.customize ['storageattach', :id,  '--storagectl', 'SATA', '--port', dconf[:port], '--device', 0, '--type', 'hdd', '--medium', dconf[:dfile]]
                       end
                       
                    end
              
   

                
         end      
            end 

    end

    
end


Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"
  #config.vm.box_version = "1804.2"

  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 1
    #v.gui = true
  end

  config.vm.define "zbx" do |zbx|
    #zbx.vm.network "forwarded_port", guest: 80, host: 8080
    zbx.vm.network "public_network", ip: "192.168.112.150"
    zbx.vm.network "private_network", ip: "192.168.50.100", virtualbox__intnet: "net1"
    zbx.vm.hostname = "zbx"
  end

  config.vm.define "cloud1" do |cloud1|
    #zbx.vm.network "forwarded_port", guest: 80, host: 8080
    cloud1.vm.network "public_network", ip: "192.168.112.151"
    cloud1.vm.network "private_network", ip: "192.168.50.101", virtualbox__intnet: "net1"
    cloud1.vm.hostname = "cloud1"
  end

  config.vm.provision "ansible" do |ansible|
    #ansible.verbose = "vvv"
    ansible.playbook = "./playbook.yml"
    ansible.become = "true"
    end


end
    