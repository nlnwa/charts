#!/usr/bin/env sh

function is_linkerd_installed {
    version=$(linkerd version | grep 'Server version' | cut -d':' -f 2 | tr -d '[:space:]')
    [ ${version} != 'unavailable' ]
}

RELEASE=local
CHART=../repo/veidemann

set -e

# Enforce minikube context (not production)
kubectl config use-context minikube

if ! is_linkerd_installed; then
    linkerd install --proxy-auto-inject | kubectl apply -f -
    linkerd check
else
    linkerd upgrade --proxy-auto-inject | kubectl apply -f -
    linkerd check
fi

# Initialize helm on client and server, wait for it to be ready
helm init --wait

helm repo update

rm -f ${CHART}/charts/*
helm dep up ${CHART}

# Upgrade/install nlnwa/veidemann into default namespace with release name "dev"
#
# Add entry to veidemann-controller's /etc/hosts file with minikube's ip pointing to the name
# of the name of the generated certs
# See (https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/)

helm upgrade ${RELEASE} ${CHART} --install \
--values values.yaml \
--set tls.create=true \
--set-file tls.key=certs/veidemann.local/key.pem \
--set-file tls.crt=certs/veidemann.local/cert.pem \
--set veidemann-controller.trustedCA.create=true \
--set veidemann-controller.trustedCA.enabled=true \
--set-file veidemann-controller.trustedCA.key=certs/minica-key.pem \
--set-file veidemann-controller.trustedCA.crt=certs/minica.pem \
--set veidemann-controller.hostAliases[0].ip=$(minikube ip) \
--set veidemann-controller.hostAliases[0].hostnames[0]=veidemann.local \
$@
