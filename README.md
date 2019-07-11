# Run Nomad and Consul with Docker in Docker
Useful when developing Linux containers on a Windows machine. 
## Build
```powershell
docker build -t hashi-dind .
```
## Usage
### Start Container
```powershell
docker run -d --name hashi-dind --privileged -p 8500:8500 -p 4646:4646 -p 3000:3000 -p 8080:8080 -p 8081:8081 -p 20000-20050:20000-20050 -v ${PWD}:/cwd hashi-dind
```
### Run Nomad Job(s)
#### Start pseudo terminal
```powershell
docker exec -it hashi-dind bash
```
#### Run Job, e.g.
```bash
nomad run jobs/hashi-ui.nomad
```
```bash
nomad run jobs/traefik.nomad
```
```bash
nomad run jobs/hello-world.nomad # -> http://localhost:8080/hello-world
```

## Port descriptions
Add/Remove port-mappings depending on your Nomad jobs / requirements 
```bash
PORTS         SERVICE
8500        - Consul API/UI
4646        - Nomad API/UI
3000        - Hashi-UI
8080        - Traefik Proxy
8081        - Traefik Dashboard # http://localhost:8081/dashboard/
20000-20050 - Nomad dynamic port range
```