#! /bin/sh

# 毎回コンテナを作り直す場合
#CONT=`docker ps -aq --filter "name=sample_admin"`
#if [ -n "$CONT" ]; then
#  docker rm --force sample_admin
#fi
#docker run --rm --name sample_admin --net=dockersample_default -e "APP_ENV=local" -v $(pwd)/project:/home/docker/project:rw -i -t sample/admin /bin/bash --login

# 実行中コンテナに接続
docker exec -it sample_admin /bin/bash --login
