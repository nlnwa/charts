#!/bin/bash

set -xe

# Enforce minikube context (not production)
kubectl config use-context minikube

# Initialize helm on client and server, wait for it to be ready
helm init --wait

# Add/update helm repo
helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
helm repo update
helm dep up ../repo/veidemann

# Upgrade/install nlnwa/veidemann into default namespace with release name "dev"
#
# Add entry to veidemann-controller's /etc/hosts file with minikube's ip pointing to the name
# of the name of the generated certs
# See (https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/)
helm upgrade dev ../repo/veidemann --install --namespace default \
--set veidemann-controller.config.hostAliases[0].ip=$(minikube ip) \
--set veidemann-controller.config.hostAliases[0].hostnames[0]=veidemann.local \
--set jaeger.cassandra.config.max_heap_size=1024M \
--set jaeger.cassandra.config.heap_new_size=256M \
--set jaeger.cassandra.resources.requests.memory=2048Mi \
--set jaeger.cassandra.resources.requests.cpu=0.4 \
--set jaeger.cassandra.resources.limits.memory=2048Mi \
--set jaeger.cassandra.resources.limits.cpu=0.4 \
--set jaeger.cassandra.config.cluster_size=1 \
$@

