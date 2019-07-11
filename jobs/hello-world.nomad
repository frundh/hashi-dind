job "hello-world" {
  region = "global"
  datacenters = ["dc1"]

  type = "service"

  update {
    stagger      = "30s"
    max_parallel = 1
  }

  group "hello-world" {
    count = 2

    task "hello-world" {
      
      driver = "docker"

      config {
        image = "tutum/hello-world"

        port_map {
          http = 80
        }
      }

      service {
        name = "hello-world"
        port = "http"

        # Traefik tags
        tags = ["traefik.enable=true",
                "traefik.frontend.rule=PathPrefix:/hello-world;PathPrefixStrip:/hello-world"]

        check {
          type     = "http"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
        }
      }

      resources {
        network {
          port "http" {}
        }
      }
    }
  }
}