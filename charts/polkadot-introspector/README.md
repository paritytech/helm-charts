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
`helm-docs --chart-search-root=charts/polkadot-introspector --template-files=README.md.gotmpl`

You may encounter `files were modified by this hook` error after updating README.md.gotmpl file when using pre-commit.
This is intended behaviour. Make sure to run `git add -A` once again to stage changes in the auto-updated REAMDE.md
-->

# Polkadot Introspector Helm chart

The helm chart installs the [Polkadot introspector](https://github.com/paritytech/polkadot-introspector).

![Version: 0.4.3](https://img.shields.io/badge/Version-0.4.3-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Parity | <devops+helm@parity.io> | <https://github.com/paritytech/helm-charts> |

## Installing the chart

```console
helm repo add parity https://paritytech.github.io/helm-charts/
helm install polkadot-introspector parity/polkadot-introspector
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Assign custom affinity rules |
| extraLabels | list | `[]` | Additional common labels on pods and services |
| fullnameOverride | string | `""` | Provide a name to substitute for the full names of resources |
| image | object | `{"pullPolicy":"Always","repository":"paritytech/polkadot-introspector","tag":"latest"}` | Image for the main container |
| image.pullPolicy | string | `"Always"` | Image pull policy |
| image.repository | string | `"paritytech/polkadot-introspector"` | Image repository |
| image.tag | string | `"latest"` | Image tag |
| imagePullSecrets | list | `[]` | Reference to one or more secrets to be used when pulling images. ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ |
| ingress | object | `{"annotations":{},"className":"","enabled":false,"hosts":[{"host":"chart-example.local","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}],"tls":[]}` | Creates an ingress resource |
| ingress.annotations | object | `{}` | Annotations to add to the Ingress |
| ingress.className | string | `""` | Ingress class name |
| ingress.enabled | bool | `false` | Enable creation of Ingress |
| ingress.hosts | list | `[{"host":"chart-example.local","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}]` | A list of hosts for the Ingress |
| ingress.tls | list | `[]` | Ingress TLS configuration |
| introspector | object | `{"enableAllParas":false,"extraArgs":[],"paraIds":[],"prometheusPort":9615,"role":"block-time","rpcNodes":["wss://rpc.polkadot.io:443","wss://kusama-rpc.polkadot.io:443"],"runtime":"polkadot","verboseLogging":false}` | Introspector configuration See https://github.com/paritytech/polkadot-introspector |
| introspector.enableAllParas | bool | `false` | Enable all parachains monitoring |
| introspector.extraArgs | list | `[]` | Extra arguments to pass to the Introspector CLI |
| introspector.paraIds | list | `[]` | Parachain IDs to monitor |
| introspector.prometheusPort | int | `9615` | Prometheus exporter port |
| introspector.role | string | `"block-time"` | Role of the introspector See https://github.com/paritytech/polkadot-introspector#tools-available |
| introspector.rpcNodes | list | `["wss://rpc.polkadot.io:443","wss://kusama-rpc.polkadot.io:443"]` | RPC nodes to connect to |
| introspector.runtime | string | `"polkadot"` | Runtime type See https://github.com/paritytech/polkadot-introspector/blob/f0d77dc58b405e73b92b7dbb64252a8a76bd1984/README.md#building Value should be `polkadot` or `rococo` |
| introspector.verboseLogging | bool | `false` | Enable verbose logging |
| nameOverride | string | `""` | Provide a name in place of node for `app:` labels |
| nodeSelector | object | `{}` | Define which Nodes the Pods are scheduled on |
| podAnnotations | object | `{}` | Annotations to add to the Pod |
| podSecurityContext | object | `{"fsGroup":1000,"runAsGroup":1000,"runAsUser":1000}` | SecurityContext holds pod-level security attributes and common container settings. This defaults to non root user with uid 1000 and gid 1000. ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/ |
| podSecurityContext.fsGroup | int | `1000` | Set container's Security Context fsGroup |
| podSecurityContext.runAsGroup | int | `1000` | Set container's Security Context runAsGroup |
| podSecurityContext.runAsUser | int | `1000` | Set container's Security Context runAsUser |
| replicas | int | `1` | Number of replicas to deploy |
| resources | object | `{}` | Resource limits & requests |
| securityContext | object | `{}` | SecurityContext settings for the main container |
| service | object | `{"port":9615,"type":"ClusterIP"}` | Configration of the Service |
| service.port | int | `9615` | Service port to expose |
| service.type | string | `"ClusterIP"` | Service type |
| serviceAccount | object | `{"annotations":{},"create":true,"name":""}` | Service account for the node to use. ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/ |
| serviceAccount.annotations | object | `{}` | Annotations to add to the Service Account |
| serviceAccount.create | bool | `true` | Enable creation of a Service Account for the main container |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| serviceMonitor | object | `{"enabled":false,"interval":"1m","scrapeTimeout":"30s","targetLabels":[]}` | Service Monitor of Prometheus-Operator ref: https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/user-guides/getting-started.md#include-servicemonitors |
| serviceMonitor.enabled | bool | `false` | Enables Service Monitor |
| serviceMonitor.interval | string | `"1m"` | Scrape interval |
| serviceMonitor.scrapeTimeout | string | `"30s"` | Scrape timeout |
| serviceMonitor.targetLabels | list | `[]` | Labels to scrape |
| tolerations | list | `[]` | Tolerations for use with node taints |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
