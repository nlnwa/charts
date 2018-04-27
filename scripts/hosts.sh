#!/bin/bash


# Append or remove hostname and minikube ip to/from /etc/hosts

HOSTNAME=veidemann.local

# Remove old entries for HOSTNAME in /etc/hosts
sudo sed -i "/${HOSTNAME}/d" /etc/hosts

# Add entry for HOSTNAME in /etc/hosts pointing to minikube ip
echo "Adding mapping from veidemann.local to minikube ip to /etc/hosts:"
echo "$(minikube ip) ${HOSTNAME}" | sudo tee -a /etc/hosts
