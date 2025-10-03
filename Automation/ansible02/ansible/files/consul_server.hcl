node_name = "consul-server"
server = true
advertise_addr = "{{ GetInterfaceIP \"enp0s8\" }}"
bind_addr = "0.0.0.0"
data_dir = "/var/lib/consul"
bootstrap_expect = 1
client_addr = "0.0.0.0"
ui = true
connect {
  enabled = true
}

ports {
  grpc = 8502
}

enable_central_service_config = true

