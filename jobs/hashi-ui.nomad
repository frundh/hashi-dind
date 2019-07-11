job "hashi-ui" {
  region = "global"
  datacenters = ["dc1"]
  
  type = "service"

  group "hashi-ui" {
    count = 1

    task "hashi-ui" {
      
      driver = "docker"

      config {
        image = "jippi/hashi-ui"

        port_map {
          web   = 3000
        }
      }           

      service {       
        name = "hashi-ui"
        port = "web"

        check {
          type     = "http"
          port     = "web"
          path     = "/_status"
          interval = "10s"
          timeout  = "2s"
        }
      }     

      env {
        CONSUL_ENABLE = 1
        CONSUL_ADDR = "${attr.unique.network.ip-address}:8500"
        NOMAD_ENABLE = 1
        NOMAD_ADDR = "http://${attr.unique.network.ip-address}:4646"
      }      

      resources {
        cpu    = 100
        memory = 128

        network {
          port "web" { static = "3000" }
        }
      }
    }
  }
}