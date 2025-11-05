#!/bin/bash

echo "🔧 Setting up Argo Workflows..."

# Create namespace
kubectl create namespace argo

# Install Argo Workflows
kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.4.8/install.yaml

# Wait for pods to be ready
echo "⏳ Waiting for Argo Workflows to be ready..."
kubectl wait --for=condition=ready pod -l app=argo-server -n argo --timeout=300s

# Patch service to use NodePort
kubectl patch svc argo-server -n argo -p '{"spec": {"type": "NodePort", "ports": [{"port": 2746, "nodePort": 30000}]}}'

echo "✅ Argo Workflows setup completed!"
echo "🌐 Argo UI: http://localhost:30000"