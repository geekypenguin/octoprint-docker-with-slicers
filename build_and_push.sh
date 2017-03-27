#!/bin/bash

TAG="kennethjiang/octoprint-with-slicers:$1"
docker build -t $TAG .
docker push $TAG
