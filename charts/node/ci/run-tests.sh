#!/usr/bin/env bash
set -eu -o pipefail

KUSTOMIZE_APPLY_ATTEMPTS=5
until kustomize build --enable-helm addons | kubectl apply -f -; do
  echo "Retrying to install addons"
  if [[ $((KUSTOMIZE_APPLY_ATTEMPTS--)) -eq 0 ]]; then
    echo "Failed to install addons"
    exit 1
  fi
  sleep 10
done

echo "Waiting for addons to be ready..."
sleep 30

kustomize build --enable-helm . | kubectl apply -f -

cd ginkgo && go test --namespace node-test --kubeconfig ${KUBECONFIG:-$HOME/.kube/config}
