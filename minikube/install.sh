#!/usr/bin/env sh

set -e

# Enforce minikube context (not production)
kubectl config use-context minikube

# Initialize helm on client and server, wait for it to be ready
helm init --wait

# Add/update helm repo
helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/

# need to resolve dependencies for mesh first because requirements is not resolved recursively for subcharts
helm dep up ../repo/mesh
helm dep up ../repo/veidemann

# Upgrade/install nlnwa/veidemann into default namespace with release name "dev"

# Add entry to veidemann-controller's /etc/hosts file with minikube's ip pointing to the name
# of the name of the generated certs
# See (https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/)

helm upgrade dev ../repo/veidemann --namespace veidemann --install \
--values values.yaml \
--set tls.create=true \
--set-file tls.key=certs/tls.key \
--set-file tls.crt=certs/tls.crt \
--set veidemann-controller.trustedCA.create=true \
--set veidemann-controller.trustedCA.enabled=true \
--set-file veidemann-controller.trustedCA.key=certs/ca.key \
--set-file veidemann-controller.trustedCA.crt=certs/ca.crt \
--set veidemann-controller.hostAliases[0].ip=$(minikube ip) \
--set veidemann-controller.hostAliases[0].hostnames[0]=veidemann.local \
$@
