server = false
advertise_addr = "{{ GetInterfaceIP \"enp0s8\" }}"
data_dir = "/var/lib/consul"
bind_addr = "0.0.0.0"
client_addr = "0.0.0.0"
retry_join = ["192.168.56.11"]
connect {
  enabled = true
}

ports {
  grpc = 8502
}

enable_central_service_config = true
