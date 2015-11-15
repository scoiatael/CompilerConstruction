#!/bin/bash

IMAGE="kaleidoscope"

(docker images | grep $IMAGE) || (docker build -t $IMAGE .)

exec docker run --name $IMAGE -it --volume=$(pwd):/haskell $IMAGE
