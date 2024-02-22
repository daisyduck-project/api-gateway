#!/bin/sh
BASEDIR=$(dirname "$0")
echo "$BASEDIR"

./gradlew build

version=$(./gradlew getArtifactVersion --quiet)
echo "Version=$version"
docker build . -t api-gateway:$version --build-arg VERSION=$version

kubectl create configmap gateway-config --from-file $BASEDIR/application.yaml -o yaml --dry-run=client | kubectl apply -f -

template=`cat "$BASEDIR/deployment.yaml.template" | sed "s/{{version}}/$version/g"`
echo "$template" | kubectl apply -f -