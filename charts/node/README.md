# Substrate/Polkadot node helm chart

## Installing the chart

```console
helm repo add parity https://parity-helm-charts.storage.googleapis.com
helm install polkadot-node parity/node
```

This will deploy a single Polkadot node with the default configuration.

## Parameters

### Common parameters

| Parameter           | Description                                  | Default                        |
|---------------------|----------------------------------------------|--------------------------------|
| `nameOverride`      | String to partially override chart.fullname  | `nil`                          |
| `fullnameOverride`  | String to fully override cassandra.fullname  | `nil`                          |
| `imagePullSecrets`  | Labels to add to all deployed objects        | `[]`                           |
| `podAnnotations`    | Annotations to add to pods                   | `{}` (evaluated as a template) |
| `nodeSelector`      | Node labels for pod assignment               | `{}` (evaluated as a template) |
| `tolerations`       | Tolerations for pod assignment               | `[]` (evaluated as a template) |
| `affinity`          | Affinity for pod assignment                  | `{}` (evaluated as a template) |
| `storaceClass`      | The storage class to use for volumes         | `default`                      |

### Node parameters

| Parameter                                | Description                                                                                                               | Default                        |
|------------------------------------------|---------------------------------------------------------------------------------------------------------------------------|--------------------------------|
| `node.chain`                             | Network to connect the node to (ie `--chain`)                                                                             | `polkadot`                     |
| `node.flags`                             | Node flags other than `--name` (set from the helm release name), `--base-path` and `--chain` (both set with `node.chain`) | `--prometheus-external --rpc-external --rpc-cors all` |
| `node.dataVolumeSize`                    |                                                                                                         | `100Gi`                        |
| `node.replica`                           | Number of replica in the node StatefulSet                                                                                 | `1`                            |
| `node.chainDataSnapshotUrl`              | Download and load chain data from a snapshot archive http URL                                                             | ``                             |
| `node.chainDataGcsBucketUrl`             | Sync chain data files from a GCS bucket (eg. `gs://bucket-name/folder-name`)                                              | ``                             |
| `node.dbPath`                            | Path at which the snapshot database files will be unpacked (`/data/chains/$dbPath`)                                       | ``                             |
| `node.chainDataKubernetesVolumeSnapshot` | Initialize the chain data volume from a Kubernetes VolumeSnapshot                                                         | ``                             |
| `node.resources.limits`                  | The resources limits (cpu/memory) for nodes                                                                               | `{}`                           |
| `node.resources.requests`                | The resources requests (cpu/memory) for nodes                                                                             | `{}`                           |
| `node.serviceMonitor.enabled`            | If true, creates a Prometheus Operator ServiceMonitor                                                                     | `false`                        |
| `node.serviceMonitor.namespace`          | Prometheus namespace                                                                                                      | `nil`                          |
| `node.serviceMonitor.internal`           | Prometheus scrape interval                                                                                                | `nil`                          |
| `node.serviceMonitor.scrapeTimeout`      | Prometheus scrape timeout                                                                                                 | `nil`                          |

### Other parameters

| Parameter                          | Description                                                                                            | Default            |
|------------------------------------|--------------------------------------------------------------------------------------------------------|--------------------|
| `image.repository`                 | Node image name                                                                                        | `parity/polkadot`  |
| `image.tag`                        | Node image tag                                                                                         | `latest`           |
| `image.pullPolicy`                 | Node image pull policy                                                                                 | `Always`           |
| `initContainer.image.repository`   | Download-chain-snapshot init container image name                                                      | `crazymax/7zip`    |
| `initContainer.image.tag`          | Download-chain-snapshot init container image tag                                                       | `latest`           |
| `googleCloudSdk.image.repository`  | Sync-chain-gcs init container image name                                                               | `google/cloud-sdk` |
| `googleCloudSdk.image.tag`         | Sync-chain-gcs init container image tag                                                                | `slim`             |
| `googleCloudSdk.serviceAccountKey` | Service account key (JSON) to inject into the Sync-chain-gcs init container using a Kubernetes secret  | `nil`              |
