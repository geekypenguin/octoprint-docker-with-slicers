#!/bin/bash

VERSION=$1
TAG="kennethjiang/octoprint-with-slicers:$VERSION"
docker build -t $TAG --build-arg version=$VERSION . && docker push $TAG
