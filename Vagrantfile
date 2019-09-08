VERSION = "2"

#OS to be used by all vagrant boxes that will be created by this vagrant run
VM_BOX_OS = "centos/7"

#Provisioning details in hash map format
BOX_DETAILS = {
               "web1" => {
                          "ip" => "172.28.33.11",
                          "provisioner" => "web_setup.sh",
                          "port_forwarder" => {
                                               "8081" => "8080"
                                              }
                         },
               "web2" => {
                          "ip" => "172.28.33.12",
                          "provisioner" => "web_setup.sh",
                          "port_forwarder" => {
                                               "8082" => "8080"
                                              }
                         },
               "lb_haproxy" => {
	                        "ip" => "172.28.33.10",
				"provisioner" => "haproxy_setup.sh",
				"port_forwarder" => { 
				                     "80" => "80"
						    }
	                       }
              }

Vagrant.configure(VERSION) do |config|
  config.vm.box = VM_BOX_OS

  BOX_DETAILS.each do |key, values|
    config.vm.define "#{key}" do |machine|
      values.each do |k, v|
        if "#{k}" == "ip"
	  machine.vm.network "private_network", ip: "#{v}"
	elsif "#{k}" == "port_forwarder"
	  v.each do |host_port, guest_port|
	    machine.vm.network "forwarded_port", guest: "#{guest_port}", host: "#{host_port}"
	  end
	elsif "#{k}" == "provisioner"
	  machine.vm.provision "shell", path: "#{v}"
	end
      end  
    end
  end
end
