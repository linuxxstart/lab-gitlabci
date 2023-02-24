#!/bin/sh
# Get the registration token from:
# https://git.labci.br/admin/runners

registration_token=v19ResxZ1tK8YKdm4qae

docker exec -it git_gitlab-runner.1.ua3oxw262emb6bsc1hl2vln3d \
  gitlab-runner register \
    --non-interactive \
    --registration-token ${registration_token} \
    --locked=false \
    --description Container GitRunner \
    --url http://gitlab \
    --executor docker \
    --docker-image docker:stable \
    --docker-volumes "/var/run/docker.sock:/var/run/docker.sock" \
    --docker-network-mode rede_proxy