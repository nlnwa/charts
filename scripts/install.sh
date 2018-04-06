#!/bin/bash

set -xe

# Enforce minikube context (not production)
kubectl config use-context minikube

# Initialize helm on client and server, wait for it to be ready
helm init --wait

# Add/update helm repo
helm repo incubator https://kubernetes-charts-incubator.storage.googleapis.com/
helm repo update
helm dep up ../veidemann

# Upgrade/install nlnwa/veidemann into default namespace with release name "dev"
#
# Add entry to veidemann-controller's /etc/hosts file with minikube's ip pointing to the name
# of the name of the generated certs
# See (https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/)
helm upgrade dev ../veidemann --install --namespace default \
--set veidemann-controller.config.hostAliases[0].ip=$(minikube ip) \
--set veidemann-controller.config.hostAliases[0].hostnames[0]=veidemann.local \
$@
