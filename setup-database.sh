#!/bin/bash

if [ $1 == "install" ]; then

    docker network create -d bridge roachnet


    --name=roach1 \
    --hostname=roach1 \
    --net=roachnet \
    -p 26257:26257 -p 8080:8080  \
    -v "${PWD}/cockroach-data/roach1:/cockroach/cockroach-data"  \
    cockroachdb/cockroach:v20.1.11 start \
    --insecure \
    --join=roach1,roach2,roach3


    docker run -d \
    --name=roach2 \
    --hostname=roach2 \
    --net=roachnet \
    -v "${PWD}/cockroach-data/roach2:/cockroach/cockroach-data" \
    cockroachdb/cockroach:v20.1.11 start \
    --insecure \
    --join=roach1,roach2,roach3


    docker run -d \
    --name=roach3 \
    --hostname=roach3 \
    --net=roachnet \
    -v "${PWD}/cockroach-data/roach3:/cockroach/cockroach-data" \
    cockroachdb/cockroach:v20.1.11 start \
    --insecure \
    --join=roach1,roach2,roach3


    docker exec -it roach1 ./cockroach init --insecure
    grep 'node starting' cockroach-data/roach1/logs/cockroach.log -A 11

else
    docker start roach1, roach2, roach3
fi


python -c 'import todo; todo.db.create_all()'