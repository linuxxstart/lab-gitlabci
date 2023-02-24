# Criando um ambiente de teste para treinamento de Gitlab CI.

## 1 - Criando certificado local autoassinado 
```
cd certificado
.cert.sh *.labci.br
```
Domínio labci.br foi criado e já está na pasta certificado. Caso queira mudar o nome do domínio faço o mesmo procedimendo trocando o nome do comando acima.

## 2 - Subindo o HAproxy com balancedor de carga e descoberta de containers

### 2.1 - Gerar arquivo .pem

Primreiro vou gerar o arquivo .pem para coloca na pasta ssl do HAproxy. Com os certificados gerados no passo anterior, vamos fazer um "cat" nos arquivos para gerar um novo.

```
cat *.labci.br.crt *.labci.br.key rootCA.crt > labci.pem
```
Agora copia o arquivo "labci.pem" para a pasta haproxy/lab/haproxy/ssl.

Obs.: Esses arquivos de certificados já existem, só é necessário fazer este procedimento caso queira trocar o nome do domínio.

### 2.2 - Criando swarm 

Para subir os containers como serviço vamos habilitar o swarm no docker
```
docker swarm init
```
### 2.3 -  Criar  rede para os serviços
```
docker network create --driver overlay --attachable rede_proxy
```
### 2.4- Fazer o deploy do haproxy
```
docker stack deploy -c haproxy/lab/docker-compose.yml haproxy
```
### 2.5- Fazer o reload da configuração do HAproxy
```
docker kill --signal USR2 $(docker container ls --filter name=haproxy_haproxy --quiet)
```

https://www.haproxy.com/blog/haproxy-on-docker-swarm-load-balancing-and-dns-service-discovery/



## 3 - Subindo um serviço registry

Vamos criar 2 serviços, 1 vai ser o registry de imagens docker e outro vai ser um browser para visualizar as imagens geradas.
```
docker stack deploy -c registry/docker-compose.yml registry
```

## 4 - Subindo o Gitlab

Criando os seriços do Gitlab e Gitlab Runner. Após o gitlab iniciar vamos pegar a senha de root gerada na instalação para poder acessar.

```
docker stack deploy -c gitlab/docker-compose.yml git
```
```
docker exec -it git_gitlab grep 'Password:' /etc/gitlab/initial_root_password
```
Obs.: Verificar se o nome do container é "git_gilab" apenas.

### 4.1 - Gitlab Runner

Depois de acessar o gitlab e pegar o token, editar o script gitlab-runner-register.sh e adicionar o token, depois executar o script no servidor onde está o container do gitlab-runner.

```
./gitlab/gitlab-runner-register.sh 
```


[<img src="https://i9.ytimg.com/vi/QExBnuOb2SM/maxresdefault.jpg" width="50%">](https://www.youtube.com/watch?v=QExBnuOb2SM "Gitlab CI/CD")

