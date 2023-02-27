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
helm install polkadot-node parity/node --set node.chainDataSnapshotUrl=https://dot-rocksdb.polkashots.io/snapshot --set node.chainDataSnapshotFormat=lz4
```

Kusama:
```console
helm install kusama-node parity/node --set node.chainDataSnapshotUrl=https://ksm-rocksdb.polkashots.io/snapshot --set node.chainDataSnapshotFormat=lz4 --set node.chainPath=ksmcc3
```
⚠️ For some chains where the local directory name is different from the chain ID, `node.chainPath` needs to be set to a custom value.

### Resizing the node disk

To resize the node persistent volume, perform the following steps:

1. Patch the PVC storage size, eg. to `1000Gi`:

```console
kubectl patch pvc chain-data-polkadot-node-0  -p '{"spec":{"resources":{"requests":{"storage":"1000Gi"}}}}}'
```

2. Delete the StatefulSet object with `cascade=orphan` (ie. without removing the attached pods):

```console
kubectl delete sts polkadot-node --cascade=orphan
```

3. Update the `node.dataVolumeSize` to the new value (eg. `1000Gi`) and upgrade the helm release.

Note that for a Kubernetes Persistent Volume Claims to be resizable, its StorageClass must have specific characteristics. More information on this topic is available in the [Expanding Persistent Volumes Claims
section of the Kubernetes documentation](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#expanding-persistent-volumes-claims).

### Optional Vault Integration

To integrate this chart with vault:
- Vault agent injector [installed](https://www.vaultproject.io/docs/platform/k8s/injector/installation) on the cluster
- Kubernetes [auth enabled](https://learn.hashicorp.com/tutorials/vault/kubernetes-sidecar#configure-kubernetes-authentication) in your vault instance
- Secrets for either the keys or the nodeKey created in your vault using kv-2
- A policy for each of your secrets configured in your vault
- an authentication role crated in your vault instance (should match the serviceAccount name for this chart) with policies for accessing your keys attached

```
node:
  vault:
    keys:
      - name: aura
        type: aura
        scheme: sr25519
        vaultPath: kv/secret/polkadot-node # path at which the secret is located in Vault
        vaultKey: aura # key under which the secret value is stored in Vault
        extraDerivation: "//${HOSTNAME}//aura" # allows to have unique derived keys for each pod of the statefulset
    nodeKey:
      name: nodekey
      vaultPath: kv/secret/polkadot-node
      vaultKey: nodekey
```

## Upgrade
### From v3.x.x to v4.0.0 (⚠️ breaking changes)

The following chart parameters have been renamed or rearranged:

- `node.pruning` -> `node.chainData.pruning`
- `node.database` -> `node.chainData.database`
- `node.collator.isParachain` -> `node.isParachain`
- `node.collator.relayChain` -> `node.collatorRelayChain.chain`
- `node.collator.relayChainCustomChainspecPath` -> `node.collatorRelayChain.customChainspecPath`
- `node.collator.relayChainCustomChainspecUrl` -> `node.collatorRelayChain.customChainspecUrl`
- `node.collator.relayChainFlags` -> `node.collatorRelayChain.flags`
- `node.collator.relayChainData.*` -> `node.collatorRelayChain.chainData.*`
- `node.collator.relayChainPruning` -> `node.collatorRelayChain.chainData.pruning`
- `node.collator.relayChainDatabase` -> `node.collatorRelayChain.chainData.database`
- `node.collator.relayChainKeystore.*` -> `node.collatorRelayChain.chainKeystore.*`
- `node.collator.relayChainPrometheus.*` -> `node.collatorRelayChain.prometheus.*`

The following flags are now invalid if they were previously set in `node.flags` or `node.collator.relayChainFlags`.
An error will be thrown if any of those flags are set directly.

- `--name`
- `--base-path`
- `--chain`
- `--validator`
- `--collator`
- `--light`
- `--database`
- `--pruning`
- `--prometheus-external`
- `--prometheus-port`
- `--node-key`
- `--wasm-runtime-overrides`
- `--jaeger-agent`
- `--rpc-methods`
- `--rpc-external`
- `--unsafe-rpc-external`
- `--ws-external`
- `--unsafe-ws-external`
- `--rpc-cors`
- `--rpc-port`
- `--ws-port`

### From v2.x.x to v3.0.0 (⚠️ breaking changes)
There are now separate volumes for:
- relaychain data
- relaychain keystore
- parachain data
- parachain keystore

Some chart parameters have been grouped together and renamed. There are now separate sections for the following values:
- `node.chainData`
- `node.chainKeystore`
- `node.collator`

Common `storageClass` parameter has been moved to the corresponding separate groups mentioned above.

As both the chain data and keystore can now be stored on up to 4 different volumes you may need to manually relocate the existing data to the newly created volumes.

If you're running a non-collator node:
- Move chain files from the `/data/chains/<chain_name>` in the `chain-data` volume to `/chain-data` in the `chain-data` volume.
- Move keystore files from the `/data/chains/<chain_name>/keystore` in the `chain-data` volume to `/keystore` in the `chain-keystore` volume.

If you're running a collator node:
- Move chain files from the `/data/chains/<chain_name>` in the `chain-data` volume to `/chain-data` in the `chain-data` volume.
- Move keystore files from the `/data/chains/<chain_name>/keystore` in the `chain-data` volume to `/keystore` in the `chain-keystore` volume.
- Move relaychain files from the `/data/relay/polkadot` in the `chain-data` volume to `/relaychain-data/polkadot` in the `relaychain-data` volume.
- Move relaychain keystore from `/data/relay/polkadot/chains/<relay_chain_name>/keystore` in the `chain-data` volume to `/relaychain-keystore` in the `relaychain-keystore` volume

## Parameters

### Common parameters

| Parameter           | Description                                  | Default                        |
|---------------------|----------------------------------------------|--------------------------------|
| `nameOverride`      | String to partially override node.fullname   | `nil`                          |
| `fullnameOverride`  | String to fully override node.fullname       | `nil`                          |
| `imagePullSecrets`  | Labels to add to all deployed objects        | `[]`                           |
| `podAnnotations`    | Annotations to add to pods                   | `{}` (evaluated as a template) |
| `nodeSelector`      | Node labels for pod assignment               | `{}` (evaluated as a template) |
| `tolerations`       | Tolerations for pod assignment               | `[]` (evaluated as a template) |
| `affinity`          | Affinity for pod assignment                  | `{}` (evaluated as a template) |

### Node parameters

| Parameter                                                                 | Description                                                                                                                                                                                                                                          | Default                                                             |
|---------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------|
| `node.chain`                                                              | Network to connect the node to (ie `--chain`)                                                                                                                                                                                                        | `polkadot`                                                          |
| `node.command`                                                            | Command to be invoked to launch the node binary                                                                                                                                                                                                      | `polkadot`                                                          |
| `node.flags`                                                              | Node flags other than `--name` (set from the helm release name), `--base-path` and `--chain` (both set with `node.chain`)                                                                                                                            | `--prometheus-external --rpc-external --ws-external --rpc-cors all` |
| `node.keys`                                                               | The list of keys to inject on the node before startup (object{ type, scheme, seed }), supercedes `node.vault.keys`                                                                                                                                   | `{}`                                                                |
| `node.vault.authPath`                                                     | Set the vault-agent authentication path (defaults to `auth/kubernetes`)                                                                                                                                                                              | `nil`                                                               |
| `node.vault.authRole`                                                     | Set the vault role to be used by the vault-agent (defaults to the service account name)                                                                                                                                                              | `nil`                                                               |
| `node.vault.authType`                                                     | Set the vault-agent authentication type (defaults to `kubernetes` when not set)                                                                                                                                                                      | `nil`                                                               |
| `node.vault.authConfigType`                                               | Set the vault-agent authentication additional `type` parameter                                                                                                                                                                                       | `nil`                                                               |
| `node.vault.authConfigServiceAccount`                                     | Set the vault-agent authentication additional `service-account` parameter                                                                                                                                                                            | `nil`                                                               |
| `node.vault.keys`                                                         | The list of vault secrets to inject on the node before startup (object{name, vaultPath, vaultKey, scheme, type, extraDerivation}). Note that the vaultKey must be alphanumeric.                                                                      | `{}`                                                                |
| `node.vault.nodeKey`                                                      | The vault secret to inject as a custom nodeKey (the secrets value must be 64 byte hex) (object {name, vaultPath, vaultKey, vaultKeyAppendPodIndex})                                                                                                  | `{}`                                                                |
| `node.vault.nodeKey.vaultKeyAppendPodIndex`                               | If true, append the pod index to the vaultKey used to load the node key secret from vault (ie. the key used will be `vaultKey_$INDEX`)                                                                                                               | `{}`                                                                |
| `node.persistGeneratedNodeKey`                                            | Persist the auto-generated node key inside the data volume (at /data/node-key)                                                                                                                                                                       | `false`                                                             |
| `node.customNodeKey`                                                      | Use a custom node-key, if `node.persistGeneratedNodeKey` is true then this will not be used.  (Must be 64 byte hex key), supercedes `node.vault.nodeKey`                                                                                             | `nil`                                                               |
| `node.enableStartupProbe`                                                 | If true, enable the startup probe check                                                                                                                                                                                                              | `true`                                                              |
| `node.enableSidecarReadinessProbe`                                        | If true, enable the readiness probe check through `paritytech/ws-health-exporter` running as a sidecar                                                                                                                                               | `false`                                                             |
| `node.enableChainBackupGcs`                                               | If true, creates a database backup to GCS on startup through an init container                                                                                                                                                                       | `false`                                                             |
| `node.extraEnvVars`                                                       | A list of environment variables to set for the main container                                                                                                                                                                                        | `[]`                                                                |
| `node.chainBackupGcsUrl`                                                  | URL of the GCS bucket to use for the database backup (eg. `gs://bucket-name[/folder-name]`)                                                                                                                                                          | `false`                                                             |
| `node.replica`                                                            | Number of replica in the node StatefulSet                                                                                                                                                                                                            | `1`                                                                 |
| `node.role`                                                               | Set the role of the node: `full`, `authority`/`validator`, `collator` or `light`                                                                                                                                                                     | `full`                                                              |
| `node.prometheus.enabled`                                                 | If true, enables Prometheus endpoint                                                                                                                                                                                                                 | `true`                                                              |
| `node.prometheus.port`                                                    | Port to use for the Prometheus endpoint                                                                                                                                                                                                              | `9615`                                                              |
| `node.chainData.snapshotUrl`                                              | Download and load chain data from a snapshot archive http URL                                                                                                                                                                                        | ``                                                                  |
| `node.chainData.snapshotFormat`                                           | The snapshot archive format (`tar` or `lz4`)                                                                                                                                                                                                         | `tar`                                                               |
| `node.chainData.GCSBucketUrl`                                             | Sync chain data files from a GCS bucket (eg. `gs://bucket-name[/folder-name]`)                                                                                                                                                                       | ``                                                                  |
| `node.chainData.chainPath`                                                | Path at which the chain database files are located (`/data/chains/${CHAIN_PATH}`)                                                                                                                                                                    | `nil` (if undefined, fallbacks to the value in `node.chain`)        |
| `node.chainData.kubernetesVolumeSnapshot`                                 | Initialize the chain data volume from a Kubernetes VolumeSnapshot                                                                                                                                                                                    | ``                                                                  |
| `node.chainData.kubernetesVolumeToClone`                                  | Initialize the chain data volume from a existing Kubernetes PVC                                                                                                                                                                                      | ``                                                                  |
| `node.chainData.volumeSize`                                               | The size of the chain data PersistentVolume                                                                                                                                                                                                          | `100Gi`                                                             |
| `node.chainData.storageClass`                                             | Storage Class to use for chain data PersistentVolume                                                                                                                                                                                                 | `default`                                                           |
| `node.chainData.annotations`                                              | Annotations to be set on chain data PersistentVolume                                                                                                                                                                                                 | `default`                                                           |
| `node.chainKeystore.volumeSize`                                           | The size of the chain keystore PersistentVolume                                                                                                                                                                                                      | `10Mi`                                                              |
| `node.chainKeystore.storageClass`                                         | Storage Class to use for chain keystore PersistentVolume                                                                                                                                                                                             | `default`                                                           |
| `node.chainKeystore.annotations`                                          | Annotations to be set on chain keystore PersistentVolume                                                                                                                                                                                             | `default`                                                           |
| `node.chainKeystore.accessModes`                                          | Access modes to use for chain keystore PersistentVolume                                                                                                                                                                                              | `["ReadWriteOnce"]`                                                 |
| `node.chainKeystore.mountInMemory.enabled`                                | If true, use the in-memory volume to keep the chain keystore instead of persisting it to the disk                                                                                                                                                    | `false`                                                             |
| `node.chainKeystore.mountInMemory.sizeLimit`                              | The size of the in-memory volume for the chain keystore. Requires K8s >=1.22                                                                                                                                                                         | `nil`                                                               |
| `node.customChainspecUrl`                                                 | Download and use a custom chainspec file from a URL                                                                                                                                                                                                  | `nil`                                                               |
| `node.database`                                                           | Set the database backend to use and that will be passed to the `--database` flag (`rocksdb`, `paritydb` or `nil`)                                                                                                                                    | `nil`                                                               |
| `node.forceDownloadChainspec`                                             | Force the chainspec download even if it is already present on the volume                                                                                                                                                                             | `false`                                                             |
| `node.allowUnsafeRpcMethods`                                              | If true, allows unsafe RPC methods by setting `--rpc-methods=unsafe`                                                                                                                                                                                 | false                                                               |
| `node.isParachain`                                                        | If true, configure the node as a parachain (set the relay-chain flags after `--`)                                                                                                                                                                    | `nil`                                                               |
| `node.collatorRelayChain.customChainspecUrl`                              | Download and use a custom relay-chain chainspec file from a URL                                                                                                                                                                                      | `nil`                                                               |
| `node.collatorRelayChain.chainData.snapshotUrl`                           | Download and load relay-chain data from a snapshot archive http URL                                                                                                                                                                                  | `nil`                                                               |
| `node.collatorRelayChain.chainData.snapshotFormat`                        | The relay-chain snapshot archive format (`tar` or `lz4`)                                                                                                                                                                                             | `nil`                                                               |
| `node.collatorRelayChain.chainData.chainPath`                             | Path at which the chain database files are located (`/relaychain-data/chains/${RELAY_CHAIN_PATH}`)                                                                                                                                                   | `nil`                                                               |
| `node.collatorRelayChain.chainData.GCSBucketUrl`                          | Sync relay-chain data files from a GCS bucket (eg. `gs://bucket-name/folder-name`)                                                                                                                                                                   | `nil`                                                               |
| `node.collatorRelayChain.chainData.kubernetesVolumeSnapshot`              | Initialize the relay chain data volume from a Kubernetes VolumeSnapshot                                                                                                                                                                              | ``                                                                  |
| `node.collatorRelayChain.chainData.kubernetesVolumeToClone`               | Initialize the relay chain data volume from a existing Kubernetes PVC                                                                                                                                                                                | ``                                                                  |
| `node.collatorRelayChain.chainData.volumeSize`                            | The size of the relay chain data PersistentVolume                                                                                                                                                                                                    | `100Gi`                                                             |
| `node.collatorRelayChain.chainData.storageClass`                          | Storage Class to use for relay chain data PersistentVolume                                                                                                                                                                                           | `default`                                                           |
| `node.collatorRelayChain.chainData.annotations`                           | Annotations to be set on relay chain data PersistentVolume                                                                                                                                                                                           | `default`                                                           |
| `node.collatorRelayChain.chainKeystore.volumeSize`                        | The size of the relay chain keystore PersistentVolume                                                                                                                                                                                                | `10Mi`                                                              |
| `node.collatorRelayChain.chainKeystore.storageClass`                      | Storage Class to use for relay chain keystore PersistentVolume                                                                                                                                                                                       | `default`                                                           |
| `node.collatorRelayChain.chainKeystore.annotations`                       | Annotations to be set on relay chain keystore PersistentVolume                                                                                                                                                                                       | `default`                                                           |
| `node.collatorRelayChain.chainKeystore.accessModes`                       | Access modes to use for relay chain keystore PersistentVolume                                                                                                                                                                                        | `["ReadWriteOnce"]`                                                 |
| `node.collatorRelayChain.chainKeystore.mountInMemory.enabled`             | If true, use the in-memory volume to keep the relay chain keystore instead of persisting it to the disk                                                                                                                                              | `false`                                                             |
| `node.collatorRelayChain.chainKeystore.mountInMemory.sizeLimit`           | The size of the in-memory volume for the relay chain keystore. Requires K8s >=1.22                                                                                                                                                                   | `nil`                                                               |
| `node.collatorRelayChain.flags`                                           | Relay-chain node flags other than `--name` (set from the helm release name), `--base-path` and `--chain`                                                                                                                                             | `nil`                                                               |
| `node.collatorRelayChain.prometheus.enabled`                              | If true, enables Prometheus endpoint for relaychain                                                                                                                                                                                                  | `false`                                                             |
| `node.collatorRelayChain.prometheus.port`                                 | Port to use for the Relaychain Service Prometheus endpoint                                                                                                                                                                                           | `9625`                                                              |
| `node.resources.limits`                                                   | The resources limits (cpu/memory) for nodes                                                                                                                                                                                                          | `{}`                                                                |
| `node.podManagementPolicy`                                                | The pod management policy to apply to the StatefulSet, set it to `Parallel` to launch or terminate all Pods in parallel, and not to wait for pods to become Running and Ready or completely terminated prior to launching or terminating another pod | `{}`                                                                |
| `node.chainData.pruning`                                                  | The amount of blocks to retain. Set to a number or set to 0 for `--pruning=archive` .                                                                                                                                                                | `nil`                                                               |
| `node.perNodeServices.apiService.enabled`                                 | If true, creates a an API Service for every node in the statefulset exposing the HTTP, WS and Prometheus endpoints                                                                                                                                   | `true`                                                              |
| `node.perNodeServices.apiService.type`                                    | Define the type of the API Services (`ClusterIP`, `NodePort` or `LoadBalancer`)                                                                                                                                                                      | `ClusterIP`                                                         |
| `node.perNodeServices.apiService.annotations`                             | Annotations to be set on API Services                                                                                                                                                                                                                | `{}`                                                                |
| `node.perNodeServices.apiService.httpPort`                                | Port to use for the API Service HTTP endpoint                                                                                                                                                                                                        | `9933`                                                              |
| `node.perNodeServices.apiService.wsPort`                                  | Port to use for the API Service WS endpoint                                                                                                                                                                                                          | `9944`                                                              |
| `node.perNodeServices.apiService.prometheusPort`                          | Port to use for the API Service Prometheus endpoint                                                                                                                                                                                                  | `9615`                                                              |
| `node.perNodeServices.apiService.externalDns.enabled`                     | If true, adds an [external-dns](https://github.com/kubernetes-sigs/external-dns) annotation to set a DNS record directing to the API Service                                                                                                         | `false`                                                             |
| `node.perNodeServices.apiService.externalDns.hostname`                    | Define the base hostname for the external-dns DNS record which will be  (eg. for `hostname: example.com`, the annotation set will be `external-dns.alpha.kubernetes.io/hostname: POD_NAME.example.com`)                                              | `example.com`                                                       |
| `node.perNodeServices.apiService.externalDns.ttl`                         | Define the TTL to be set for the external-dns DNS record                                                                                                                                                                                             | `300`                                                               |
| `node.perNodeServices.apiService.externalDns.customPrefix`                | Custom prefix to use instead of prefixing the hostname with the name of the Pod                                                                                                                                                                                             | `""`                                                               |
| `node.perNodeServices.relayP2pService.enabled`                            | If true, creates a relay-chain P2P Service for every node in the statefulset exposing the TCP P2P endpoint                                                                                                                                           | `true`                                                              |
| `node.perNodeServices.relayP2pService.type`                               | Define the type of the relay-chain P2P Services (`ClusterIP`, `NodePort` or `LoadBalancer`)                                                                                                                                                          | `ClusterIP`                                                         |
| `node.perNodeServices.relayP2pService.annotations`                        | Annotations to be set on relay-chain P2P Services                                                                                                                                                                                                    | `{}`                                                                |
| `node.perNodeServices.relayP2pService.port`                               | Port to use to expose the relay-chain P2P Service externally                                                                                                                                                                                         | `9944`                                                              |
| `node.perNodeServices.relayP2pService.ws.enabled`                         | If true, creates a relay-chain P2P Service for every node in the statefulset exposing the WebSocket P2P endpoint                                                                                                                                     | `false`                                                             |
| `node.perNodeServices.relayP2pService.ws.port`                            | Port to use to expose the relay-chain WebSocket P2P Service externally                                                                                                                                                                               | `30334`                                                             |
| `node.perNodeServices.relayP2pService.externalDns.enabled`                | If true, adds an [external-dns](https://github.com/kubernetes-sigs/external-dns) annotation to set a DNS record directing to the relay-chain P2P Service                                                                                             | `false`                                                             |
| `node.perNodeServices.relayP2pService.externalDns.hostname`               | Define the base hostname for the relay-chain P2P Service external-dns DNS record which will be  (eg. for `hostname: example.com`, the annotation set will be `external-dns.alpha.kubernetes.io/hostname: POD_NAME.example.com`)                      | `example.com`                                                       |
| `node.perNodeServices.relayP2pService.externalDns.ttl`                    | Define the TTL to be set for the relay-chain P2P Service external-dns DNS record                                                                                                                                                                     | `300`                                                               |
| `node.perNodeServices.relayP2pService.externalDns.customPrefix`           | Custom prefix to use instead of prefixing the hostname with the name of the Pod                                                                                                                                                                                             | `""`                                                               |
| `node.perNodeServices.paraP2pService.enabled`                             | If true, creates a relay-chain P2P Service for every node in the statefulset exposing the HTTP, WS and Prometheus endpoints                                                                                                                          | `true`                                                              |
| `node.perNodeServices.paraP2pService.type`                                | Define the type of the relay-chain P2P Services (`ClusterIP`, `NodePort` or `LoadBalancer`)                                                                                                                                                          | `ClusterIP`                                                         |
| `node.perNodeServices.paraP2pService.annotations`                         | Annotations to be set on relay-chain P2P Services                                                                                                                                                                                                    | `{}`                                                                |
| `node.perNodeServices.paraP2pService.port`                                | Port to use to expose the relay-chain P2P Service externally                                                                                                                                                                                         | `9944`                                                              |
| `node.perNodeServices.paraP2pService.ws.enabled`                          | If true, creates a para-chain P2P Service for every node in the statefulset exposing the WebSocket P2P endpoint                                                                                                                                      | `false`                                                             |
| `node.perNodeServices.paraP2pService.ws.port`                             | Port to use to expose the para-chain WebSocket P2P Service externally                                                                                                                                                                                | `30335`                                                             |
| `node.perNodeServices.paraP2pService.externalDns.enabled`                 | If true, adds an [external-dns](https://github.com/kubernetes-sigs/external-dns) annotation to set a DNS record directing to the relay-chain P2P Service                                                                                             | `false`                                                             |
| `node.perNodeServices.paraP2pService.externalDns.hostname`                | Define the base hostname for the relay-chain P2P Service external-dns DNS record which will be  (eg. for `hostname: example.com`, the annotation set will be `external-dns.alpha.kubernetes.io/hostname: POD_NAME.example.com`)                      | `example.com`                                                       |
| `node.perNodeServices.paraP2pService.externalDns.ttl`                     | Define the TTL to be set for the relay-chain P2P Service external-dns DNS record                                                                                                                                                                     | `300`                                                               |
| `node.perNodeServices.paraP2pService.externalDns.customPrefix`            | Custom prefix to use instead of prefixing the hostname with the name of the Pod                                                                                                                                                                                             | `""`                                                               |
| `node.resources.requests`                                                 | The resources requests (cpu/memory) for nodes                                                                                                                                                                                                        | `{}`                                                                |
| `node.serviceMonitor.enabled`                                             | If true, creates a Prometheus Operator ServiceMonitor                                                                                                                                                                                                | `false`                                                             |
| `node.serviceMonitor.namespace`                                           | Prometheus namespace                                                                                                                                                                                                                                 | `nil`                                                               |
| `node.serviceMonitor.internal`                                            | Prometheus scrape interval                                                                                                                                                                                                                           | `nil`                                                               |
| `node.serviceMonitor.scrapeTimeout`                                       | Prometheus scrape timeout                                                                                                                                                                                                                            | `nil`                                                               |
| `node.serviceMonitor.targetLabels`                                        | transfers labels on the Kubernetes Pod onto service monitor                                                                                                                                                                                          | `[nodes]`                                                           |
| `node.tracing.enabled`                                                    | If true, creates a jaeger agent sidecar                                                                                                                                                                                                              | `false`                                                             |
| `node.subtrateApiSiecar.enabled`                                          | If true, creates a substrate api sidecar                                                                                                                                                                                                             | `false`                                                             |
| `node.perNodeServices.setPublicAddressToExternalIp.enabled`               | If true sets the `--public-addr` flag to be the NodePort p2p services external address                                                                                                                                                               | `false`                                                             |
| `node.perNodeServices.setPublicAddressToExternalIP.ipRetrievalServiceUrl` | The external service to return the NodePort IP                                                                                                                                                                                                       | `https://ifconfig.io`                                               |

### Other parameters

| Parameter                          | Description                                                                                           | Default                                                                       |
|------------------------------------|-------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------|
| `image.repository`                 | Node image name                                                                                       | `parity/polkadot`                                                             |
| `image.tag`                        | Node image tag                                                                                        | `latest`                                                                      |
| `image.pullPolicy`                 | Node image pull policy                                                                                | `Always`                                                                      |
| `initContainer.image.repository`   | Download-chain-snapshot init container image name                                                     | `alpine`                                                                      |
| `initContainer.image.tag`          | Download-chain-snapshot init container image tag                                                      | `latest`                                                                      |
| `googleCloudSdk.image.repository`  | Sync-chain-gcs init container image name                                                              | `google/cloud-sdk`                                                            |
| `googleCloudSdk.image.tag`         | Sync-chain-gcs init container image tag                                                               | `slim`                                                                        |
| `googleCloudSdk.serviceAccountKey` | Service account key (JSON) to inject into the Sync-chain-gcs init container using a Kubernetes secret | `nil`                                                                         |
| `googleCloudSdk.gsutilFlags`       | Adds custom flags to the gsutil rsync command to copy the chain database from/to Gcs                  | `-m -o 'GSUtil:parallel_process_count=8' -o 'GSUtil:parallel_thread_count=4'` |
| `ingress.enabled`                  | If true, creates an ingress                                                                           | `false`                                                                       |
| `ingress.annotations`              | Annotations to add to the ingress (key/value pairs)                                                   | `{}`                                                                          |
| `ingress.rules`                    | Set rules on the ingress                                                                              | `[]`                                                                          |
| `ingress.tls`                      | Set TLS configuration on the ingress                                                                  | `[]`                                                                          |
| `podSecurityContext`               | Set the pod security context for the substrate node container                                         | `{ runAsUser: 1000, runAsGroup: 1000, fsGroup: 1000 }`                        |
| `jaegerAgent.image.repository`     | Jaeger agent image repository                                                                         | `jaegertracing/jaeger-agent`                                                  |
| `jaegerAgent.image.tag`            | Jaeger agent image tag                                                                                | `1.28.0`                                                                      |
| `jaegerAgent.ports.compactPort`    | Port to use for jaeger.thrift over compact thrift protocol                                            | `6831`                                                                        |
| `jaegerAgent.ports.binaryPort`     | Port to use for jaeger.thrift over binary thrift protocol                                             | `6832`                                                                        |
| `jaegerAgent.ports.samplingPort`   | Port for HTTP sampling strategies                                                                     | `5778`                                                                        |
| `jaegerAgent.collector.url`        | The URL which jaeger agent sends data                                                                 | `nil`                                                                         |
| `jaegerAgent.collector.port   `    | The port which jaeger agent sends data                                                                | `14250`                                                                       |
| `extraContainers   `               | Sidecar containers to add to the node                                                                 | `[]`                                                                          |
| `extraInitContainers   `           | Additional init containers to run in the pod                                                                 | `[]`                                                                          |
| `serviceAccount`                   | ServiceAccount used in init containers                                                                | `{create: true, createRoleBinding: true,  annotations: {}}`                   |
| `autoscaling.enabled`              | Enable the horizontal-pod-autoscaler                                                                  | `false`                                                                        |
| `autoscaling.minReplicas`          | The minimum amount of HPA enabled replicas                                                            | `""`                                                                       |
| `autoscaling.maxReplicas`          | The maximum amount of HPA enabled replicas                                                            | `""`                                                                       |
| `autoscaling.targetCPU`            | The target average CPU utilization at which to scale up another pod                                   | `""`                                                                       |
| `autoscaling.targetMemory`         | The target average memory utilization at which to scale up another pod                                | `""`                                                                       |
| `autoscaling.additionalMetrics`    | A list of additional metric types use to scale up                                                     | `{}`                                                                       |
