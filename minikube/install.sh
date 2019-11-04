#!/usr/bin/env sh

function is_linkerd_installed {
    version=$(linkerd version | grep 'Server version' | cut -d':' -f 2 | tr -d '[:space:]')
    [ ${version} != 'unavailable' ]
}

RELEASE=local
CHART=../repo/veidemann

set -e

./hosts.sh

# Enforce minikube context (not production)
kubectl config use-context minikube

if ! is_linkerd_installed; then
    linkerd install | kubectl apply -f -
    linkerd check
else
    linkerd upgrade | kubectl apply -f -
    linkerd check
fi

# Create persistent volum claims
kubectl apply -f pvc/

# Initialize helm on client and server, wait for it to be ready
helm init --wait

helm repo update

./upgrade.sh $@
