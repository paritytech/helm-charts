<!--
DO NOT EDIT README.md manually!
We're using [helm-docs](https://github.com/norwoodj/helm-docs) to render values of the chart.
If you updated values.yaml file make sure to render a new README.md locally before submitting a Pull Request.

If you're using [pre-commit](https://pre-commit.com/) make sure to install the hooks first:
```
pre-commit install
```
REAMDE.md will be updating automatically after that.

Otherwise, you should install helm-docs and manually update README.md. Navigate to repository root and run:
`helm-docs --chart-search-root=charts/polkadot-stps --template-files=README.md.gotmpl`

You may encounter `files were modified by this hook` error after updating README.md.gotmpl file when using pre-commit.
This is intended behaviour. Make sure to run `git add -A` once again to stage changes in the auto-updated REAMDE.md
-->

# Polkadot stps Helm chart

The helm chart installs [Polkadot STPS](https://github.com/paritytech/polkadot-stps).

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Parity | <devops+helm@parity.io> | <https://github.com/paritytech/helm-charts> |

## Installing the chart

```console
helm repo add parity https://paritytech.github.io/helm-charts/
helm install polkadot-stps parity/polkadot-stps
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Assign custom affinity rules |
| extraLabels | list | `[]` | Additional common labels on pods and services |
| fullnameOverride | string | `""` | Provide a name to substitute for the full names of resources |
| imagePullSecrets | list | `[]` | Reference to one or more secrets to be used when pulling images. ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ |
| nameOverride | string | `""` | Provide a name in place of node for `app:` labels |
| nodeSelector | object | `{}` | Define which Nodes the Pods are scheduled on |
| podAnnotations | object | `{}` | Annotations to add to the Pod |
| podSecurityContext | object | `{"fsGroup":1000,"runAsGroup":1000,"runAsUser":1000}` | SecurityContext holds pod-level security attributes and common container settings. This defaults to non root user with uid 1000 and gid 1000. ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/ |
| podSecurityContext.fsGroup | int | `1000` | Set container's Security Context fsGroup |
| podSecurityContext.runAsGroup | int | `1000` | Set container's Security Context runAsGroup |
| podSecurityContext.runAsUser | int | `1000` | Set container's Security Context runAsUser |
| replicas | int | `1` | Number of replicas to deploy (TPS counter) |
| resources | object | `{}` | Resource limits & requests |
| securityContext | object | `{}` | SecurityContext settings for the main container |
| sender | object | `{"args":[],"enabled":false,"image":{"pullPolicy":"Always","repository":"paritytech/stps-sender","tag":"rococo-latest"},"replicas":1}` | Configuration for transaction sender util |
| sender.args | list | `[]` | Additional args for the transaction sender CLI |
| sender.enabled | bool | `false` | Enable transaction sender |
| sender.image | object | `{"pullPolicy":"Always","repository":"paritytech/stps-sender","tag":"rococo-latest"}` | Image of the transaction sender |
| sender.image.pullPolicy | string | `"Always"` | Image pull policy |
| sender.image.repository | string | `"paritytech/stps-sender"` | Image repository |
| sender.image.tag | string | `"rococo-latest"` | Image tag |
| sender.replicas | int | `1` | Number of replicas to deploy (transaction senders) |
| service | object | `{"port":9615,"portName":"http","type":"ClusterIP"}` | Configure Service parameters |
| service.port | int | `9615` | Port to expose the Service on |
| service.portName | string | `"http"` | Name of the Service port |
| service.type | string | `"ClusterIP"` | Service type |
| serviceMonitor | object | `{"enabled":false,"interval":"5s","scrapeTimeout":"5s","targetLabels":[]}` | Service Monitor of Prometheus-Operator ref: https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/user-guides/getting-started.md#include-servicemonitors |
| serviceMonitor.enabled | bool | `false` | Enables Service Monitor |
| serviceMonitor.interval | string | `"5s"` | Scrape interval |
| serviceMonitor.scrapeTimeout | string | `"5s"` | Scrape timeout |
| serviceMonitor.targetLabels | list | `[]` | Labels to scrape |
| tolerations | list | `[]` | Tolerations for use with node taints |
| tps | object | `{"args":[],"enabled":true,"image":{"pullPolicy":"Always","repository":"paritytech/stps-tps","tag":"rococo-latest"},"paraBlockFinality":{"enabled":true},"prometheus":{"enabled":true,"port":65432},"scrapeFromGenesis":{"enabled":false}}` | Configuration for TPS counter util |
| tps.args | list | `[]` | Additional args for the TPS counter CLI |
| tps.enabled | bool | `true` | Enable TPS counter |
| tps.image | object | `{"pullPolicy":"Always","repository":"paritytech/stps-tps","tag":"rococo-latest"}` | Image of the TPS counter |
| tps.image.pullPolicy | string | `"Always"` | Image pull policy |
| tps.image.repository | string | `"paritytech/stps-tps"` | Image repository |
| tps.image.tag | string | `"rococo-latest"` | Image tag |
| tps.paraBlockFinality | object | `{"enabled":true}` | Whether to monitor relay-chain, or para-chain finality. If set to true, tps will subscribe to CandidateIncluded events on the relaychain node, and scrape Balances Transfer events concurrently with a collator node RPC client |
| tps.paraBlockFinality.enabled | bool | `true` | Enable chain finality monitoring |
| tps.prometheus | object | `{"enabled":true,"port":65432}` | Prometheus exporter configuration |
| tps.prometheus.enabled | bool | `true` | Enable Prometheus exporter |
| tps.prometheus.port | int | `65432` | Prometheus exporter port |
| tps.scrapeFromGenesis | object | `{"enabled":false}` | Whether to subscribe to blocks from genesis or not. For zombienet tests, this should be set to true. When deploying tps in more long-living networks, set this to false (or simply omit it) |
| tps.scrapeFromGenesis.enabled | bool | `false` | Enable blocks subscription |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
