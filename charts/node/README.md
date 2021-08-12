# Substrate/Polkadot node helm chart

## Installing the chart

```console
helm repo add parity https://paritytech.github.io/helm-charts/
helm install polkadot-node parity/node
```

This will deploy a single Polkadot node with the default configuration.

### Deploying a node with data synced from a snapshot archive (eg. [Polkashot](https://polkashots.io/))

Polkadot:
```console
helm install polkadot-node parity/node --set node.chainDataSnapshotUrl=https://dot-rocksdb.polkashots.io/snapshot --set node.chainDataSnapshotFormat=7z
```

Kusama:
```console
helm install kusama-node parity/node --set node.chainDataSnapshotUrl=https://ksm-rocksdb.polkashots.io/snapshot --set node.chainDataSnapshotFormat=7z --set node.chainPath=ksmcc3
```
⚠️ For some chains where the local directory name is different from the chain ID, `node.chainPath` needs to be set to a custom value.

## Parameters

### Common parameters

| Parameter           | Description                                  | Default                        |
|---------------------|----------------------------------------------|--------------------------------|
| `nameOverride`      | String to partially override chart.fullname  | `nil`                          |
| `fullnameOverride`  | String to fully override chart.fullname      | `nil`                          |
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
| `node.dataVolumeSize`                    | The size of the chain data PersistentVolume                                                                               | `100Gi`                        |
| `node.replica`                           | Number of replica in the node StatefulSet                                                                                 | `1`                            |
| `node.chainDataSnapshotUrl`              | Download and load chain data from a snapshot archive http URL                                                             | ``                             |
| `node.chainDataSnapshotExtractionPath`   | The path at which the snapshot archive downloaded from a http URL will be extracted                                       | `/data/chains/${CHAIN_PATH}`   |
| `node.chainDataSnapshotFormat`           | The snapshot archive format (`tar` or `7z`)                                                                               | `tar`                          |
| `node.chainDataGcsBucketUrl`             | Sync chain data files from a GCS bucket (eg. `gs://bucket-name/folder-name`)                                              | ``                             |
| `node.chainPath`                         | Path at which the chain database files are located (`/data/chains/${CHAIN_PATH}`)                                         | `nil` (if undefined, fallbacks to the value in `node.chain`) |
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
| `ingress.enabled`                  | If true, creates an ingress                                                                            | `false`            |
| `ingress.annotations`              | Annotations to add to the ingress (key/value pairs)                                                    | `{}`               |
| `ingress.rules`                    | Set rules on the ingress                                                                               | `[]`              |
| `ingress.tls`                      | Set TLS configuration on the ingress                                                                   | `[]`              |
