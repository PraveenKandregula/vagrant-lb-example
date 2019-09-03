VERSION = "2"

Vagrant.configure(VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  #config.vm.box_version = "v20190429.0.1"

  config.vm.define "haproxy" do |haproxy|
    haproxy.vm.network "forwarded_port", guest: 80, host: 8000
    haproxy.vm.network "forwarded_port", guest: 8080, host: 8081
    haproxy.vm.network "private_network", ip: "172.28.33.10"
  end
end


