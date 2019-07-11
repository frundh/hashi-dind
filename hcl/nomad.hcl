datacenter = "dc1"
data_dir = "/opt/nomad"

server {
  enabled = true
  bootstrap_expect = 1
}

client {
  enabled = true
  network_interface = "eth0"
  reserved {
    # limit dynamic port range to 20000-20050 from default 20000-32000
    reserved_ports = "20051-32000"
  }
  options = {
    "docker.privileged.enabled" = "true"
  }
}