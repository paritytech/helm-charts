# Substrate/Polkadot node helm chart

## Installing the chart

```console
helm repo add parity https://paritytech.github.io/helm-charts/
helm install substrate-runtime-exporter parity/substrate-runtime-exporter -set runtimeExporter.wsProvider="ws://susbtrate-node.example.com"
```

This will deploy the [substrate-runtime-exporter](https://github.com/paritytech/polkadot-runtime-prom-exporter) and connect it to a substrate node.
Note that the attached substrate node should be run with `--rpc-max-payload=1000` and `--ws-max-out-buffer-capacity=1000` to support heavy RPC requests from the exporter.

## Parameters

### Common parameters

| Parameter            | Description                                | Default                        |
|----------------------|--------------------------------------------|--------------------------------|
| `imagePullSecrets`   | Labels to add to all deployed objects      | `[]`                           |
| `nameOverride`       | String to partially override node.fullname | `nil`                          |
| `fullnameOverride`   | String to fully override node.fullname     | `nil`                          |
| `podSecurityContext` | Specify the pod security settings          | `{}`                           |  
| `resources`          | Resources to set on pods                   | `{}`                           |  
| `nodeSelector`       | Node labels for pod assignment             | `{}`                           |  
| `tolerations`        | Tolerations for pod assignment             | `[]`                           |  
| `affinity`           | Affinity for pod assignment                | `{}`                           |  

### Runtime exporter parameters

| Parameter                     | Description                 | Default |
|-------------------------------|-----------------------------|---------|
| `runtimeExporter.wsProvider`  | Websocket URL to connect to | ``      |
| `runtimeExporter.logLevel`    | Log level                   | `info`  |
