#!/usr/bin/env sh


# Append or remove hostname and minikube ip to/from /etc/hosts

HOSTNAME=veidemann.local
MINIKUBE_IP=$(minikube ip)

# Remove old entries for HOSTNAME in /etc/hosts
sudo sed -i "/${HOSTNAME}/d" /etc/hosts

# Add entry for HOSTNAME in /etc/hosts pointing to minikube ip
echo "Adding mapping from veidemann.local to minikube ip to /etc/hosts:"
echo "${MINIKUBE_IP} ${HOSTNAME}" | sudo tee -a /etc/hosts
