#!/bin/bash

# Update package list and install prerequisites
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install KinD (Kubernetes in Docker)
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.10.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/

# Install kubectl (Kubernetes command-line tool)
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Create a KinD cluster
kind create cluster --name my-cluster

# Set the kubeconfig context to the KinD cluster
kubectl cluster-info --context kind-my-cluster

# Verify the installation
kubectl version --short
docker --version
kind version
