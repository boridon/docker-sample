#! /bin/sh
CONT=`docker ps -aq --filter "name=sample_admin"`
if [ -n "$CONT" ]; then
  docker rm --force sample_admin
fi
docker run --rm --name sample_admin --net=dockersample_default -v $(pwd)/project:/home/docker/project:rw -i -t sample/admin /bin/bash --login
