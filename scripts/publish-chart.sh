# Package helm chart archive
helm package .
mkdir charts
mv node*.tgz charts
# Generate updated index based on the existing one
gsutil cp gs://parity-helm-charts/index.yaml index.yaml
helm repo index \
  --url https://parity-helm-charts.storage.googleapis.com \
  --merge index.yaml \
  charts/
# Copy new archive and updated index to bucket
gsutil cp -r charts/* gs://parity-helm-charts

# Cleanup
rm -rf charts/ index.yaml
