# 1- Criar  rede para os serviços
```
docker network create --driver overlay --attachable rede_proxy
```
## 1.1- Fazer o deploy do haproxy
```
docker stack deploy -c docker-compose.yml haproxy
```
## 1.2- Fazer o reload da configuração do HAproxy
```
docker kill --signal USR2 $(docker container ls --filter name=haproxy_haproxy --quiet)
```

https://www.haproxy.com/blog/haproxy-on-docker-swarm-load-balancing-and-dns-service-discovery/