FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates curl bsdtar nano supervisor && \
    curl -sSL https://get.docker.com/ | sh && \
    curl -SL https://github.com/docker/compose/releases/download/1.20.1/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose && \
    curl -SL https://releases.hashicorp.com/consul/1.5.1/consul_1.5.1_linux_amd64.zip | bsdtar -xf- -C /usr/local/bin/ && chmod +x /usr/local/bin/consul && \
    curl -SL https://releases.hashicorp.com/nomad/0.9.3/nomad_0.9.3_linux_amd64.zip | bsdtar -xf- -C /usr/local/bin/ && chmod +x /usr/local/bin/nomad && \
    apt-get remove -y bsdtar && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir /etc/nomad /etc/consul /etc/consul/config

COPY ./hcl/consul.hcl /etc/consul/
COPY ./hcl/nomad.hcl /etc/nomad/
COPY entrypoint.sh /
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

WORKDIR /cwd
EXPOSE 4646 8500 20000-20050