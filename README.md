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

### Node parameters

| Parameter                                | Description                                                                                                               | Default                        |
|------------------------------------------|---------------------------------------------------------------------------------------------------------------------------|--------------------------------|
| `node.chain`                             | Network to connect the node to (ie `--chain`)                                                                             | `polkadot`                     |
| `node.flags`                             | Node flags other than `--name` (set from the helm release name), `--base-path` and `--chain` (both set with `node.chain`) | `--prometheus-external --rpc-external --rpc-cors all` |
| `node.dataVolumeSize`                    | Size of the Kubernetes Volume to provision for the chain data                                                             | `100Gi`                        |
| `node.replica`                           | Number of replica in the node StatefulSet                                                                                 | `1`                            |
| `node.chainDataSnapshotUrl`              | Download and load chain data from a snapshot archive http URL                                                             | ``                             |
| `node.dbPath`                            | Path at which the snapshot database files will be unpacked (`/data/chains/$dbPath`)                                       | ``                             |
| `node.chainDataKubernetesVolumeSnapshot` | Initialize the chain data volume from a Kubernetes VolumeSnapshot                                                         | ``                             |
| `node.resources.limits`                  | The resources limits (cpu/memory) for nodes                                                                               | `{}`                           |
| `node.resources.requests`                | The resources requests (cpu/memory) for nodes                                                                             | `{}`                           |
| `node.serviceMonitor.enabled`            | If true, creates a Prometheus Operator ServiceMonitor                                                                     | `false`                        |
| `node.serviceMonitor.namespace`          | Prometheus namespace                                                                                                      | `nil`                          |
| `node.serviceMonitor.internal`           | Prometheus scrape interval                                                                                                | `nil`                          |
| `node.serviceMonitor.scrapeTimeout`      | Prometheus scrape timeout                                                                                                 | `nil`                          |
