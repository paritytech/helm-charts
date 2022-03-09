# Polkadot introspector helm chart

The helm chart installs Polkadot introspector. The repo is located in https://github.com/paritytech/polkadot-introspector.

## Installing the chart

```console
helm repo add parity https://paritytech.github.io/helm-charts/
helm install polkadot-introspector parity/polkadot-introspector 
```

## Parameters

### Common parameters

| Parameter           | Description                                                                | Default                        |
|---------------------|----------------------------------------------------------------------------|--------------------------------|
| `nameOverride`                     | String to partially override node.fullname                  | `nil`                          |
| `fullnameOverride`                 | String to fully override node.fullname                      | `nil`                          |
| `imagePullSecrets`                 | Labels to add to all deployed objects                       | `[]`                           |
| `podAnnotations`                   | Annotations to add to pods                                  | `{}`                           |  
| `nodeSelector`                     | Node labels for pod assignment                              | `{}`                           |  
| `tolerations`                      | Tolerations for pod assignment                              | `[]`                           |  
| `affinity`                         | Affinity for pod assignment                                 | `{}`                           |  
| `extraLabels`                      | Tolerations for pod assignment                              | `[]`                           |  
| `replicas`                         | Number of replicas                                          | `1`                            |
| `extraLabels   `                   | Extra labels to add in all resources                        | `{}`                           |                
| `serviceMonitor.enabled`           | If true, creates a Prometheus Operator ServiceMonitor       | `false`                        | 
| `serviceMonitor.internal`          | Prometheus scrape interval                                  | `1m`                           |                                                                                                 
| `serviceMonitor.scrapeTimeout`     | Prometheus scrape timeout                                   | `30s`                          |
| `serviceMonitor.targetLabels`      | Transfers labels on Kubernetes  onto the  metrics           | `[]`                           |

### Introspector parameters

| Parameter                     | Description                                              | Default                                                            |
|-------------------------------|----------------------------------------------------------|--------------------------------------------------------------------|
| `introspector.role`           | Main subcommand to use by introspector                   | `block-time-monitor`                                               |
| `introspector.rpcNodes`       | List of RPC nodes to connect when in block-time-monitor  | `wss://rpc.polkadot.io:443,wss://kusama-rpc.polkadot.io:443`       |
| `introspector.prometheusPort` | Prometheus Port to expose the metrics                    | `9615`                                                             |