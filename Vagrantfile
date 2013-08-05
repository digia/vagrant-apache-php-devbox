# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|

    config.vm.box = "precise32"

    config.vm.box_url = "http://files.vagrantup.com/precise32.box"

    config.vm.network :forwarded_port, guest: 80, host: 8080
    config.vm.network :forwarded_port, guest: 443, host: 8088
    config.vm.network :forwarded_port, guest: 9000, host: 9000

    config.vm.network :private_network, ip: "192.168.10.3"

    # Set the Timezone to something useful
    config.vm.provision :shell, :inline => "echo \"America/Detroit\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"

    config.vm.synced_folder "~/Dropbox/Client/", "/var/www/", :nfs => true

    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

    config.vm.provision :puppet do |puppet|
        puppet.module_path = "modules"
        puppet.manifests_path = "manifests"
        puppet.manifest_file  = "devbox.pp"
        puppet.options="--verbose"
    end
end
