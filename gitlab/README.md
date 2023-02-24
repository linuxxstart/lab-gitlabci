# Subindo containers para testar ci/cd do gitlab 
```
#docker stack deploy -c docker-compose.yml git
```
 Editar o script gitlab-runner-register.sh e adicionar o token, depois executar o script no servidor onde está o container do gitlab-runner

# Ver a senha de root do gitlab

docker exec -it git_gitlab grep 'Password:' /etc/gitlab/initial_root_password