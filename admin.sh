#! /bin/sh
docker run --rm --name sample_admin --net=dockersample_default -v $(pwd)/project:/home/docker/project:rw -i -t sample/admin /bin/bash --login
