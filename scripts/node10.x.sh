#!/usr/bin/env bash
sh scripts/prepare-build.sh
cp lambda_env/node10.x/Dockerfile build/Dockerfile && cd build/

docker build -t  shawnliu/puppeteer-lambda:node10.x  .

docker run --rm  -it \
-v "$PWD/src":/var/task/src \
-v "$PWD/test":/var/task/test \
shawnliu/puppeteer-lambda:node10.x